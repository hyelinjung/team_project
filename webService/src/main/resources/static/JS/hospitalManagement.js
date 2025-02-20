let userId = /*[[${user.user_id}]]*/{};
let userAuthority = /*[[${user.user_authority}]]*/{};
/*<![CDATA[*/
window.onload = function () {
    viewHospital();
}

let currentPage = 1; // 현재 페이지
const itemsPerPage = 10; // 한 페이지당 보여줄 개수
let totalPages = 1; // 총 페이지 수

function viewHospital() {
    let tbody = document.getElementById("hospitalList");
    tbody.innerHTML = "";

    $.ajax({
        url: "/asklepios/viewHospitalList",
        type: "get",
        success: function (hospitalVOList) {
            console.log(hospitalVOList)
            if (hospitalVOList.length === 0) {
                document.getElementById("hospitalTable").style.display = "none";
                return;
            }

            totalPages = Math.ceil(hospitalVOList.length / itemsPerPage); // 전체 페이지 계산
            displayPageData(hospitalVOList, currentPage);
            createPagination(totalPages);
        },
        error: function () {
            alert("예약 현황을 불러오는 데 실패했습니다.");
        }
    });
}

function displayPageData(data, page) {
    let tbody = document.getElementById("hospitalList");
    tbody.innerHTML = ""; // 기존 데이터 삭제

    let start = (page - 1) * itemsPerPage;
    let end = start + itemsPerPage;
    let pageData = data.slice(start, end); // 해당 페이지의 데이터만 가져오기

    pageData.forEach(hospital => {
        const newRow = tbody.insertRow();
        newRow.style.textAlign = "center";
        newRow.style.height = "50px";
        newRow.onclick = function (){
            openModal(hospital);
        }

        let newCell1 = newRow.insertCell(0);
        let newCell2 = newRow.insertCell(1);
        let newCell3 = newRow.insertCell(2);
        let newCell4 = newRow.insertCell(3);
        let newCell5 = newRow.insertCell(4);

        newCell1.innerHTML = `<p>${hospital.hospital_code}</p>`;
        newCell2.innerHTML = `<p>${hospital.hospital_name}</p>`;
        newCell3.innerHTML = `<p>${hospital.hospital_addr}</p>`;
        newCell4.innerHTML = `<p>${hospital.hospital_tel}</p>`;
        newCell5.innerHTML = `<p>${hospital.hospital_accept}</p>`;
        // newCell5.innerHTML = `<a href="/downloadCertification?filename=${hospital.hospital_certification}" download>PDF 다운로드</a>`;

        if (hospital.hospital_accept === "승인") {
            newCell5.style.color = "green";
        } else if (hospital.hospital_accept === "대기") {
            newCell5.style.color = "#3b82f6";
        } else {
            newCell5.style.color = "red";
        }
    });
}

function createPagination(totalPages) {
    let paginationContainer = document.getElementById("pagination");

    if (!paginationContainer) {
        console.error("pagination 요소를 찾을 수 없습니다.");
        return; // pagination 요소가 없으면 실행 중단
    }

    paginationContainer.innerHTML = ""; // 기존 페이지네이션 삭제

    let startPage = Math.floor((currentPage - 1) / 10) * 10 + 1;
    let endPage = Math.min(startPage + 9, totalPages);

    if (startPage > 1) {
        let prevBtn = document.createElement("button");
        prevBtn.innerHTML = `<i class="fa-solid fa-chevron-left"></i>`;
        prevBtn.style.fontWeight = "bold";
        prevBtn.style.fontSize = "25px";
        prevBtn.style.padding = "20px";
        prevBtn.onclick = function () {
            currentPage = startPage - 1;
            viewHospital();
        };
        paginationContainer.appendChild(prevBtn);
    }

    for (let i = startPage; i <= endPage; i++) {
        let pageBtn = document.createElement("button");
        pageBtn.innerText = i;
        pageBtn.classList.add("page-btn");
        pageBtn.style.fontSize = "25px";
        pageBtn.style.padding = "20px";
        if (i === currentPage) {
            pageBtn.style.fontWeight = "bold";
            pageBtn.style.color = "#3b82f6";
        }
        pageBtn.onclick = function () {
            currentPage = i;
            viewHospital();
        };
        paginationContainer.appendChild(pageBtn);
    }

    if (endPage < totalPages) {
        let nextBtn = document.createElement("button");
        nextBtn.innerHTML = `<i class="fa-solid fa-chevron-right"></i>`;
        nextBtn.style.fontWeight = "bold";
        nextBtn.style.fontSize = "25px";
        nextBtn.style.padding = "20px";
        nextBtn.onclick = function () {
            currentPage = endPage + 1;
            viewHospital();
        };
        paginationContainer.appendChild(nextBtn);
    }
}

// 병원 정보를 모달로 띄우는 함수
function openModal(hospital) {
    // 모달에 병원 정보 설정
    document.getElementById("modalHospitalName").textContent = hospital.hospital_name;
    document.getElementById("modalHospitalAddr").textContent = hospital.hospital_addr;
    document.getElementById("modalHospitalTel").textContent = hospital.hospital_tel;
    document.getElementById("modalHospitalTime").textContent = hospital.hospital_time;
    document.getElementById("modalHospitalNotice").textContent = hospital.hospital_notice;
    document.getElementById("modalHospitalIntro").textContent = hospital.hospital_intro;
    document.getElementById("modalHospitalCertification").innerHTML = `<a href="/downloadCertification?filename=${hospital.hospital_certification}" download><img style="width: 60px; float: left" src="Img/pdf_icon.png">증명서 다운로드</a>`;

    // 모달 표시
    document.getElementById("hospitalModal").style.display = "flex";

    let mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 1 // 지도의 확대 레벨
        };
    let map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
    let geocoder = new kakao.maps.services.Geocoder();

    geocoder.addressSearch(hospital.hospital_addr, function(result, status) {

        // 정상적으로 검색이 완료됐으면
        if (status === kakao.maps.services.Status.OK) {

            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });

            // 인포윈도우로 장소에 대한 설명을 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: `<div style="width:150px;text-align:center;padding:6px 0;">${hospital.hospital_name}</div>`
            });
            infowindow.open(map, marker);

            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
        }
    });

}

// 모달 닫기
function closeModal() {
    document.getElementById("hospitalModal").style.display = "none";
}

// 병원 승인
function approval(){
    let hospitalName = document.getElementById("modalHospitalName").textContent;

    $.ajax({
        url: "/asklepios/approval",
        type: "get",
        data: {
            hospital_name : hospitalName
        },
        success: function () {
            Swal.fire('승인 완료', `${hospitalName}의 등록을 승인했습니다!`,'success');
            viewHospital();
        },
        error: function () {
            alert("승인에 실패했습니다.");
        }
    });
}

// 병원 거절
function disapproval(){
    let hospitalName = document.getElementById("modalHospitalName").textContent;

    $.ajax({
        url: "/asklepios/disapproval",
        type: "get",
        data: {
            hospital_name : hospitalName
        },
        success: function () {
            Swal.fire('거절 완료', `${hospitalName}을 등록을 거절했습니다!`,'success');
            viewHospital();
        },
        error: function () {
            alert("거절에 실패했습니다.");
        }
    });
}


