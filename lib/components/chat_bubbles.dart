import 'package:expandable_text/expandable_text.dart';

import 'package:t_or_d/routes/exports.dart';
import 'package:t_or_d/utils/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TextMessage extends StatelessWidget {
  final String time;
  final bool isUser;
  final String message;
  const TextMessage({
    Key? key,
    required this.isUser,
    required this.message,
    required this.time,
  }) : super(key: key);
  static const _borderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isUser == true ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: isUser == true
                          ? const Radius.circular(_borderRadius)
                          : const Radius.circular(_borderRadius),
                      bottomLeft: isUser == true
                          ? const Radius.circular(_borderRadius)
                          : const Radius.circular(0.0),
                      bottomRight: isUser == true
                          ? const Radius.circular(_borderRadius)
                          : const Radius.circular(_borderRadius),
                      topRight: isUser == true
                          ? const Radius.circular(0.0)
                          : const Radius.circular(_borderRadius)),
                  color:
                      isUser ? AppColors.primaryColor : Colors.grey.shade300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Text for the sender
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 10.0,
                    ),
                    child: Container(
                      //color: Colors.yellow,
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 144,
                          minWidth: 90),
                      child: ExpandableText(
                        message,
                        onUrlTap: (url) {
                          if ((url).isValidEmail()) {
                            launchUrlString('mailto:$url',
                                mode: LaunchMode.externalApplication);
                          } else {
                            if ((url).contains('http')) {
                              launchUrlString(url,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              launchUrlString('https:$url',
                                  mode: LaunchMode.externalApplication);
                            }
                          }
                        },
                        style: isUser == false
                            ? const TextStyle(
                                color: Colors.black,
                              )
                            : const TextStyle(
                                color: Colors.white,
                              ),
                        expandText: 'Read More',
                        maxLines: 4,
                        linkStyle: const TextStyle(
                          color: Colors.blue,
                        ),
                        urlStyle: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      right: 10.0,
                      bottom: 10.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          time,
                          style: isUser == false
                              ? const TextStyle(
                                  color: Colors.black, fontSize: 10)
                              : const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
