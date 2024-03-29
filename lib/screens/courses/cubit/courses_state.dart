part of 'courses_cubit.dart';

class CoursesState extends Equatable {
  const CoursesState({
    required this.status,
    required this.list,
    required this.types,
    this.errorMessage,
    this.selectedType = 0,
  });

  factory CoursesState.init() {
    return CoursesState(
      types: [],
      status: LoadStatus.loading,
      list: PagedListModel.empty(),
    );
  }

  factory CoursesState.success(
      PagedListModel<CourseModel> list, List<CourseTypeModel> types) {
    return CoursesState(
      status: LoadStatus.success,
      list: list,
      types: types,
    );
  }

  factory CoursesState.failure(String message) {
    return CoursesState(
      status: LoadStatus.failure,
      errorMessage: message,
      list: PagedListModel.empty<CourseModel>(),
      types: [],
    );
  }

  final LoadStatus status;
  final PagedListModel<CourseModel> list;
  final List<CourseTypeModel> types;
  final String? errorMessage;
  final int selectedType;

  @override
  List<Object?> get props => [status, list, errorMessage, types, selectedType];

  CoursesState copyWith({
    LoadStatus? status,
    PagedListModel<CourseModel>? list,
    List<CourseTypeModel>? types,
    String? errorMessage,
    int? selectedType,
  }) {
    return CoursesState(
      status: status ?? this.status,
      list: list ?? this.list,
      types: types ?? this.types,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedType: selectedType ?? this.selectedType,
    );
  }
}
