import 'package:flutter/material.dart';
import 'package:flutter_apppl/bloc/landing_page/landingpage_bloc.dart';
import 'package:flutter_apppl/helper/size_configs.dart';
import 'package:flutter_apppl/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  LandingPagebloc? landingBloc;
  bool play = true;

  @override
  void initState() {
    // TODO: implement initState
    landingBloc = BlocProvider.of<LandingPagebloc>(context);
    landingBloc!.initializeSpeech();
    //landingBloc!.add(());

    super.initState();
  }

  @override
  void dispose() {
    landingBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    final _height = sizeConfig.safeHeight! * 100;
    final _width = sizeConfig.safeWidth! * 100;

    return Scaffold(
      appBar: AppBar(
        title: Text("PingoLearn"),
      ),
      body: SafeArea(
        child: BlocBuilder<LandingPagebloc, LandingpageState>(
            builder: (BuildContext context, LandingpageState state) {
          if (state is InitLanadingPageState) {
            return Container(
              child: Column(
                children: [
                  Text("Press Button to start Listening"),
                  Container(
                    margin: EdgeInsets.only(
                        top: _height - 130, left: _width / 2 - 20),
                    child: InkWell(
                        onTap: () {
                          landingBloc!.add(ListenVoice());
                        },
                        child: Icon(
                          Icons.mic_none,
                          size: 40,
                          color: Colors.green,
                        )),
                  ),
                ],
              ),
            );
          }
          if (state is Listening) {
            return Container(
              child: Column(
                children: [
                  Text("Listenig your voice"),
                ],
              ),
            );
          }
          if (state is ListenVoiceState) {
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: 10,
                    // ),
                    TextContainer(
                      data: state.name!,
                      heading: "Your word:",
                    ),
                    // SizedBox(
                    //   height:10,
                    // ),
                    TextContainer(
                      data: state.meaning!,
                      heading: "Meaning:",
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    TextContainer(
                      data: state.example!,
                      heading: "Example:",
                    ),
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.network(state.imageUrl!)),
                    InkWell(
                        onTap: () {
                          landingBloc!.add(Stop());
                        },
                        child: Icon(
                          Icons.mic_none,
                          size: 40,
                          color: Colors.red,
                        )),
                  ],
                ),
              ),
            );
          } else if (state is ErrorLandingPage) {
            return Container(
              child: InkWell(
                onTap: () {
                  landingBloc!.add(Stop());
                },
                child: Image.network(
                    "https://i0.wp.com/www.complexsql.com/wp-content/uploads/2017/12/No-data-found-banner.png?ssl=1"),
              ),
            );
          }
          return Container(
            child: const Center(
              child: Text('Some issue come  check internet / API  '),
            ),
          );
        }),
      ),
    );
  }
}
