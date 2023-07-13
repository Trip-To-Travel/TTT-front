import 'package:flutter/material.dart';
import 'package:app/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final int primaryColor = 0xff76BDFF;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(primaryColor),
          gradient: LinearGradient(
            colors: [Color(primaryColor), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        //alignment: Alignment.center,
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(milliseconds: 1500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 로고
              Row(
                children: [
                  SizedBox(
                    width: 35.0,
                  ),
                  Image.asset(
                    'assets/images/img.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              // Trip
              Row(
                children: [
                  SizedBox(
                    width: 50.0,
                  ),
                  DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                    child: Text('Trip'),
                  ),
                ],
              ),
              // To
              Row(
                children: [
                  SizedBox(
                    width: 50.0,
                  ),
                  DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                    child: Text('To'),
                  ),
                ],
              ),
              // Travel
              Row(
                children: [
                  SizedBox(
                    width: 50.0,
                  ),
                  DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                    child: Text('Travel'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 150.0,
                    ),
                    //Image(image: AssetImage('assets/images/img.png')),

                    // 구글
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home())
                        );
                      },
                      child: Row(
                        //spaceEvenly: 요소들을 균등하게 배치하는 속성
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Text(
                            '구글로 시작하기',
                            style: TextStyle(
                              color: Color(000000).withOpacity(0.54),
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        //shadowColor: Colors.black, 그림자 추가하는 속성
                        maximumSize: Size.fromHeight(40), // 높이만 50으로 설정
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                            // shape : 버튼의 모양을 디자인 하는 기능
                            borderRadius: BorderRadius.circular(4.0)),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    // 카카오
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Home())
                        );
                      },
                      child: Row(
                        //spaceEvenly: 요소들을 균등하게 배치하는 속성
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Opacity(
                            opacity: 0.9,
                            child: Image.asset(
                              'assets/images/kakao.png',
                              width: 18,
                              height: 18,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Text(
                            '카카오로 시작하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFEE500),
                        minimumSize: Size.fromHeight(40),
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    // 네이버
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Home())
                        );
                      },
                      child: Row(
                        //spaceEvenly: 요소들을 균등하게 배치하는 속성
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Text(
                            '네이버로 시작하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF03C75A),
                        minimumSize: Size.fromHeight(40),
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));

    //   Scaffold(
    //   body: Padding(
    //     padding: const EdgeInsets.symmetric(
    //       horizontal: 50.0,
    //     ),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         // 구글
    //         ElevatedButton(
    //           onPressed: (){},
    //           child: Row(
    //             //spaceEvenly: 요소들을 균등하게 배치하는 속성
    //             //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Image.asset(
    //                 'images/google.png',
    //                 width: 18,
    //                 height: 18,
    //                 fit: BoxFit.cover,
    //               ),
    //               Text(
    //                 'Login with Google',
    //                 style: TextStyle(
    //                   color: Color(000000).withOpacity(0.54),
    //                   fontSize: 14.0,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           style: ElevatedButton.styleFrom(
    //             primary: Colors.white,
    //             //shadowColor: Colors.black, 그림자 추가하는 속성
    //             maximumSize: Size.fromHeight(40), // 높이만 50으로 설정
    //             elevation: 1.0,
    //             shape: RoundedRectangleBorder(
    //                 // shape : 버튼의 모양을 디자인 하는 기능
    //                 borderRadius: BorderRadius.circular(4.0)),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 10.0,
    //         ),
    //
    //         // 카카오
    //         ElevatedButton(
    //           onPressed: () {},
    //           child: Row(
    //             //spaceEvenly: 요소들을 균등하게 배치하는 속성
    //             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Image.asset(
    //                 'images/google.png',
    //                 width: 18,
    //                 height: 18,
    //                 fit: BoxFit.cover,
    //               ),
    //
    //               Text(
    //                 'Login with Facebook',
    //                 style: TextStyle(color: Colors.white, fontSize: 15.0),
    //               ),
    //               Opacity(
    //                 opacity: 0.0,
    //                 child: Image.asset('images/glogo.png'),
    //               ),
    //             ],
    //           ),
    //           style: ElevatedButton.styleFrom(
    //             primary: Color(0xFF334D92),
    //             minimumSize: Size.fromHeight(50),
    //             elevation: 1.0,
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(4.0)),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 10.0,
    //         ),
    //
    //         // 네이버
    //         ElevatedButton(
    //           onPressed: () {},
    //           child: Row(
    //             //spaceEvenly: 요소들을 균등하게 배치하는 속성
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Icon(
    //                 Icons.mail,
    //                 color: Colors.white,
    //               ),
    //               Text(
    //                 'Login with Email',
    //                 style: TextStyle(color: Colors.white, fontSize: 15.0),
    //               ),
    //               Opacity(
    //                 opacity: 0.0,
    //                 child: Icon(
    //                   Icons.mail,
    //                   //color: Colors.white,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           style: ElevatedButton.styleFrom(
    //             primary: Colors.green,
    //             minimumSize: Size.fromHeight(50),
    //             elevation: 1.0,
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(4.0)),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
