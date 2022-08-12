import Foundation

// 문자열 일부가 일치하는지? [범위]
// [범위]
let regex1 = "[0-9]"
let test1_1 = "1".range(of: regex1, options: .regularExpression) != nil
let test1_2 = "1a".range(of: regex1, options: .regularExpression) != nil
let test1_3 = "abc".range(of: regex1, options: .regularExpression) != nil
let test1_4 = "!1".range(of: regex1, options: .regularExpression) != nil
print(test1_1, test1_2, test1_3, test1_4)
// true true false true

// 문자열 전부가 일치해야함
// ^: 시작 앵커
// &: 끝 앵커
let regex2 = "^[0-9]$"
let test2_1 = "1".range(of: regex2, options: .regularExpression) != nil
let test2_2 = "1a".range(of: regex2, options: .regularExpression) != nil
let test2_3 = "abc".range(of: regex2, options: .regularExpression) != nil
let test2_4 = "!1".range(of: regex2, options: .regularExpression) != nil
print(test2_1, test2_2, test2_3, test2_4)
// true false false false

// .* 모든 문자열
let regex3 = "^(.*)$"
let test3_1 = "1".range(of: regex3, options: .regularExpression) != nil
let test3_2 = "1a".range(of: regex3, options: .regularExpression) != nil
let test3_3 = "abc".range(of: regex3, options: .regularExpression) != nil
let test3_4 = "".range(of: regex3, options: .regularExpression) != nil
print(test3_1, test3_2, test3_3, test3_4)
// true true true true

// 한글: 가-힣
// 한글 자음: ㄱ-ㅎ
// 한글 모음: ㅏ-ㅣ
// 소문자: a-z
// 대문자: A-Z
// 숫자: 0-9
let regex4 = "[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]"
let test4_1 = "1".range(of: regex4, options: .regularExpression) != nil
let test4_2 = "가".range(of: regex4, options: .regularExpression) != nil
let test4_3 = "abc".range(of: regex4, options: .regularExpression) != nil
let test4_4 = "".range(of: regex4, options: .regularExpression) != nil
print(test4_1, test4_2, test4_3, test4_4)
// true true true false

// 아이디 입력할때 정규식 (위 정규식 응용)
// .*를 이용하여 앞뒤에 어떤 문자가 와도 상관없고 무조건 중간에 위 문자열을 포함하는 것
// 문자열 형태가 일치시키고 싶을땐 처음과 끝에 ^와 &사용
//.*와 .*사이에 ([정규식])+ 넣어서 구현
let regex5 = "^.*([가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9])+.*$"
let test5_1 = "1".range(of: regex5, options: .regularExpression) != nil
let test5_2 = "가".range(of: regex5, options: .regularExpression) != nil
let test5_3 = "!".range(of: regex5, options: .regularExpression) != nil
let test5_4 = "!abc".range(of: regex5, options: .regularExpression) != nil
print(test5_1, test5_2, test5_3, test5_4)
// true true false true

// 핸드폰 번호 정규식
// [] 대괄호 안에 여러개의 or 조건을 둘 수 있음 [0-1,7]: 0부터 1 이나 7값
// {} 중괄호 안에 앞에까지의 문자열 갯수 범위 설정이 가능 {7,8}: 앞 문자열
// 주의: 중괄호 안에 콤마로 넣을때 띄어쓰기 넣으면 안됨
let regex6 = "^01[0-1,7][0-9]{7,8}$"
let test6_1 = "01011112222".range(of: regex6, options: .regularExpression) != nil
let test6_2 = "0101234567".range(of: regex6, options: .regularExpression) != nil
let test6_3 = "011".range(of: regex6, options: .regularExpression) != nil
let test6_4 = "12311112222".range(of: regex6, options: .regularExpression) != nil
print(test6_1, test6_2, test6_3, test6_4)
// true true false false

// (3~20자리)이메일 정규식
// 주의: 중괄호 {} 안에 콤마로 넣을때 띄어쓰기 넣으면 안됨
// 대괄호 사이에 문자가 들어가면 +를 사용해서 연결해야함
// +로 연결되면 독립적으로 인식되어 마지막에 선안한 {3,20}값이 +이후의 문자열에만 적용
let regex7 = "^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+.[a-zA-Z]{3,20}$"
let test7_1 = "abc".range(of: regex7, options: .regularExpression) != nil
let test7_2 = "abc.com".range(of: regex7, options: .regularExpression) != nil
let test7_3 = "abc@abc.com".range(of: regex7, options: .regularExpression) != nil
let test7_4 = "abc@abc".range(of: regex7, options: .regularExpression) != nil
print(test7_1, test7_2, test7_3, test7_4)
// flase false true false

// 패스워드 정규식
// 위와는 다르게 중간중간 +로 연결되지 않아서 {8,50}은 전체 문자열의 길이를 의미
// ()로 묶여있으면 or조건을 의미
let regex8 = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}$"
let test8_1 = "A1".range(of: regex8, options: .regularExpression) != nil
let test8_2 = "A1a!".range(of: regex8, options: .regularExpression) != nil
let test8_3 = "abc123123".range(of: regex8, options: .regularExpression) != nil
let test8_4 = "Abc123!@#".range(of: regex8, options: .regularExpression) != nil
print(test8_1, test8_2, test8_3, test8_4)
// false false false true
