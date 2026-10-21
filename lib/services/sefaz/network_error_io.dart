import 'dart:io';

bool isLowLevelNetworkError(Object error) => error is IOException;
