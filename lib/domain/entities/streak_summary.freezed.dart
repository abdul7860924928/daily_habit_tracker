// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streak_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StreakSummary {

 int get currentStreak; int get bestStreak; int get totalCompletedDays; double get completionRate;
/// Create a copy of StreakSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StreakSummaryCopyWith<StreakSummary> get copyWith => _$StreakSummaryCopyWithImpl<StreakSummary>(this as StreakSummary, _$identity);

  /// Serializes this StreakSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StreakSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StreakSummary&&(identical(other.currentStreak, _this.currentStreak) || other.currentStreak == _this.currentStreak)&&(identical(other.bestStreak, _this.bestStreak) || other.bestStreak == _this.bestStreak)&&(identical(other.totalCompletedDays, _this.totalCompletedDays) || other.totalCompletedDays == _this.totalCompletedDays)&&(identical(other.completionRate, _this.completionRate) || other.completionRate == _this.completionRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StreakSummary;
  return Object.hash(runtimeType,_this.currentStreak,_this.bestStreak,_this.totalCompletedDays,_this.completionRate);
}

@override
String toString() {
  final _this = this as StreakSummary;
  return 'StreakSummary(currentStreak: ${_this.currentStreak}, bestStreak: ${_this.bestStreak}, totalCompletedDays: ${_this.totalCompletedDays}, completionRate: ${_this.completionRate})';
}


}

/// @nodoc
abstract mixin class $StreakSummaryCopyWith<$Res>  {
  factory $StreakSummaryCopyWith(StreakSummary value, $Res Function(StreakSummary) _then) = _$StreakSummaryCopyWithImpl;
@useResult
$Res call({
 int currentStreak, int bestStreak, int totalCompletedDays, double completionRate
});




}
/// @nodoc
class _$StreakSummaryCopyWithImpl<$Res>
    implements $StreakSummaryCopyWith<$Res> {
  _$StreakSummaryCopyWithImpl(this._self, this._then);

  final StreakSummary _self;
  final $Res Function(StreakSummary) _then;

/// Create a copy of StreakSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStreak = null,Object? bestStreak = null,Object? totalCompletedDays = null,Object? completionRate = null,}) {
  return _then(StreakSummary(
currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,totalCompletedDays: null == totalCompletedDays ? _self.totalCompletedDays : totalCompletedDays // ignore: cast_nullable_to_non_nullable
as int,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [StreakSummary].
extension StreakSummaryPatterns on StreakSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StreakSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StreakSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StreakSummary value)  $default,){
final _that = this;
switch (_that) {
case _StreakSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StreakSummary value)?  $default,){
final _that = this;
switch (_that) {
case _StreakSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentStreak,  int bestStreak,  int totalCompletedDays,  double completionRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StreakSummary() when $default != null:
return $default(_that.currentStreak,_that.bestStreak,_that.totalCompletedDays,_that.completionRate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentStreak,  int bestStreak,  int totalCompletedDays,  double completionRate)  $default,) {final _that = this;
switch (_that) {
case _StreakSummary():
return $default(_that.currentStreak,_that.bestStreak,_that.totalCompletedDays,_that.completionRate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentStreak,  int bestStreak,  int totalCompletedDays,  double completionRate)?  $default,) {final _that = this;
switch (_that) {
case _StreakSummary() when $default != null:
return $default(_that.currentStreak,_that.bestStreak,_that.totalCompletedDays,_that.completionRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StreakSummary implements StreakSummary {
  const _StreakSummary({required this.currentStreak, required this.bestStreak, required this.totalCompletedDays, required this.completionRate});
  factory _StreakSummary.fromJson(Map<String, dynamic> json) => _$StreakSummaryFromJson(json);

@override final  int currentStreak;
@override final  int bestStreak;
@override final  int totalCompletedDays;
@override final  double completionRate;

/// Create a copy of StreakSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StreakSummaryCopyWith<_StreakSummary> get copyWith => __$StreakSummaryCopyWithImpl<_StreakSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StreakSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StreakSummary&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.totalCompletedDays, totalCompletedDays) || other.totalCompletedDays == totalCompletedDays)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,currentStreak,bestStreak,totalCompletedDays,completionRate);
}

@override
String toString() {
    return 'StreakSummary(currentStreak: $currentStreak, bestStreak: $bestStreak, totalCompletedDays: $totalCompletedDays, completionRate: $completionRate)';
}


}

/// @nodoc
abstract mixin class _$StreakSummaryCopyWith<$Res> implements $StreakSummaryCopyWith<$Res> {
  factory _$StreakSummaryCopyWith(_StreakSummary value, $Res Function(_StreakSummary) _then) = __$StreakSummaryCopyWithImpl;
@override @useResult
$Res call({
 int currentStreak, int bestStreak, int totalCompletedDays, double completionRate
});




}
/// @nodoc
class __$StreakSummaryCopyWithImpl<$Res>
    implements _$StreakSummaryCopyWith<$Res> {
  __$StreakSummaryCopyWithImpl(this._self, this._then);

  final _StreakSummary _self;
  final $Res Function(_StreakSummary) _then;

/// Create a copy of StreakSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStreak = null,Object? bestStreak = null,Object? totalCompletedDays = null,Object? completionRate = null,}) {
  return _then(_StreakSummary(
currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,totalCompletedDays: null == totalCompletedDays ? _self.totalCompletedDays : totalCompletedDays // ignore: cast_nullable_to_non_nullable
as int,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
