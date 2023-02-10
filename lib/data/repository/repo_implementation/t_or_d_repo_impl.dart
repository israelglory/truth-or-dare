import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:t_or_d/constants/app_api_config.dart';
import 'package:t_or_d/models/t_or_d_models/t_or_d_model.dart';

typedef ResMap = Map<String, dynamic>;
typedef ResList = List<Map<String, dynamic>>;

class TruthOrDareRepoImpl {
  final _dio = Dio();

  Future<TruthOrDare> truth() async {
    //_dio.options.headers.addAll({'Accept': 'application/json'});
    final res = await _dio.getUri<ResMap>(
      AppApiConfig.truthUri(),
    );
    final truth = TruthOrDare.fromMap(res.data!);
    log(res.toString());
    return truth;
  }

  Future<TruthOrDare> dare() async {
    //_dio.options.headers.addAll({'Accept': 'application/json'});
    final res = await _dio.getUri<ResMap>(
      AppApiConfig.dareUri(),
    );
    final dare = TruthOrDare.fromMap(res.data!);
    log(res.toString());
    return dare;
  }

  Future<TruthOrDare> wouldYouRather() async {
    //_dio.options.headers.addAll({'Accept': 'application/json'});
    final res = await _dio.getUri<ResMap>(
      AppApiConfig.wouldYouRatherUri(),
    );
    final wyr = TruthOrDare.fromMap(res.data!);
    log(res.toString());
    return wyr;
  }

  Future<TruthOrDare> neverHaveIEver() async {
    //_dio.options.headers.addAll({'Accept': 'application/json'});
    final res = await _dio.getUri<ResMap>(
      AppApiConfig.neverHaveIEverUri(),
    );
    final nhie = TruthOrDare.fromMap(res.data!);
    log(res.toString());
    return nhie;
  }

  Future<TruthOrDare> paranoia() async {
    //_dio.options.headers.addAll({'Accept': 'application/json'});
    final res = await _dio.getUri<ResMap>(
      AppApiConfig.paranoiaUri(),
    );
    final paranoia = TruthOrDare.fromMap(res.data!);
    log(res.toString());
    return paranoia;
  }
}
