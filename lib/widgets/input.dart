import 'package:elera/constants/constants.dart';
import 'package:elera/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magicon/magicon.dart';

class Input extends StatefulWidget {
  const Input({
    super.key,
    this.controller,
    this.textFieldType = TextInputType.text,
    this.focus,
    this.validator,
    this.isPassword = false,
    this.textCapitalization,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onChanged,
    this.nextFocus,
    this.textStyle,
    this.textAlign,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.autoFocus,
    this.readOnly,
    this.enableSuggestions,
    this.maxLength,
    this.prefix,
    this.autoFillHints,
    this.scrollPadding,
    this.cursorWidth,
    this.cursorHeight,
    this.onTap,
    this.buildCounter,
    this.inputFormatters,
    this.textAlignVertical,
    this.expands,
    this.showCursor,
    this.selectionControls,
    this.strutStyle,
    this.obscuringCharacter,
    this.keyboardAppearance,
    this.hintText,
    this.label = '',
    this.errorText,
    this.initialValue,
    this.sufix,
  });

  final TextEditingController? controller;
  final TextInputType textFieldType;
  final FocusNode? focus;
  final String? Function(String?)? validator;
  final bool isPassword;
  final String? hintText;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final FocusNode? nextFocus;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final bool? autoFocus;
  final bool? readOnly;
  final bool? enableSuggestions;
  final int? maxLength;
  final Widget? prefix;
  final Widget? sufix;
  final Iterable<String>? autoFillHints;
  final EdgeInsets? scrollPadding;
  final double? cursorWidth;
  final double? cursorHeight;
  final Function()? onTap;
  final InputCounterWidgetBuilder? buildCounter;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlignVertical? textAlignVertical;
  final bool? expands;
  final bool? showCursor;
  final TextSelectionControls? selectionControls;
  final StrutStyle? strutStyle;
  final String? obscuringCharacter;
  final Brightness? keyboardAppearance;
  final String label;
  final String? errorText;
  final String? initialValue;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(bottom: 6.w),
                child: Text(
                  widget.label,
                  style: AppTextStyles.bodyMedium(FontWeight.bold),
                ),
              )
            : Container(),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && !isPasswordVisible,
          validator: widget.validator,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.none,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: (s) {
            if (widget.nextFocus != null)
              FocusScope.of(context).requestFocus(widget.nextFocus);

            if (widget.onFieldSubmitted != null)
              widget.onFieldSubmitted!.call(s);
          },
          initialValue: widget.initialValue,
          keyboardType: widget.textFieldType,
          decoration: InputDecoration(
            filled: true,
            errorText: widget.errorText,
            errorStyle: AppTextStyles.bodyMedium(
              FontWeight.w500,
              StatusType.ERROR.color,
            ),
            errorMaxLines: 3,
            hintText: widget.hintText,
            hintStyle:
                AppTextStyles.bodyMedium(null, AppColors.greyScaleColor[500]),
            fillColor: widget.focus != null && widget.focus!.hasFocus
                ? AppColors.primaryColor.withOpacity(0.08)
                : null,
            prefixIconColor: widget.focus != null && !widget.focus!.hasFocus
                ? AppColors.greyScaleColor[500]
                : null,
            suffixIconColor: widget.focus != null && !widget.focus!.hasFocus
                ? AppColors.greyScaleColor[500]
                : null,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    child: Icon(
                      isPasswordVisible
                          ? Magicon.solidEye
                          : Magicon.solidEyeSlash,
                    ),
                    onTap: () {
                      isPasswordVisible = !isPasswordVisible;

                      setState(() {});
                    },
                  )
                : widget.sufix != null
                    ? widget.sufix
                    : null,
            prefixIcon: widget.prefix,
          ),
          focusNode: widget.focus,
          style: widget.textStyle ?? AppTextStyles.bodyMedium(FontWeight.w600),
          textAlign: widget.textAlign ?? TextAlign.start,
          maxLines: widget.textFieldType == TextInputType.streetAddress
              ? null
              : widget.maxLines ?? 1,
          minLines: widget.minLines ?? 1,
          autofocus: widget.autoFocus ?? false,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          cursorColor: AppColors.primaryColor,
          readOnly: widget.readOnly ?? false,
          maxLength: widget.maxLength,
          enableSuggestions: widget.enableSuggestions ?? true,
          autofillHints: widget.autoFillHints,
          scrollPadding: widget.scrollPadding ?? EdgeInsets.all(20),
          cursorWidth: widget.cursorWidth ?? 2.0,
          cursorHeight: widget.cursorHeight,
          cursorRadius: Radius.circular(4),
          onTap: widget.onTap,
          buildCounter: widget.buildCounter,
          scrollPhysics: BouncingScrollPhysics(),
          enableInteractiveSelection: true,
          inputFormatters: widget.inputFormatters,
          textAlignVertical: widget.textAlignVertical,
          expands: widget.expands ?? false,
          showCursor: widget.showCursor,
          selectionControls: widget.selectionControls,
          strutStyle: widget.strutStyle,
          obscuringCharacter: widget.obscuringCharacter ?? '●',
          keyboardAppearance: widget.keyboardAppearance,
        ),
      ],
    );
  }
}
