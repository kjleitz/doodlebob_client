typedef UserAttributes = ({
  String username,
  String email,
  int role, // Should be an enum

  /// Can be parsed to a `DateTime`
  String createdAt,

  /// Can be parsed to a `DateTime`
  String updatedAt,
});

typedef UserCreateAttributes = ({
  String username,
  String password,
  String? email,
});

typedef UserAdminCreateAttributes = ({
  String username,
  String password,
  String? email,
  int? role,
});

typedef UserUpdateAttributes = ({
  String? username,
  String? email,
  String? newPassword,
  String? oldPassword,
});

typedef UserAdminUpdateAttributes = ({
  String? username,
  String? email,
  String? newPassword,
  String? oldPassword,
  int? role,
});

typedef UserAuthAttributes = ({
  String? username,
  String? password,
});

typedef UserNoteResourceLinkage = ({
  String type, // "notes"
  String id,
});

typedef UserLabelResourceLinkage = ({
  String type, // "labels"
  String id, // Normally a number in the DB, but according to JSON:API spec this MUST be a string
});

typedef UserRelationships = ({
  ({List<UserNoteResourceLinkage> data})? notes,
  ({List<UserLabelResourceLinkage> data})? labels,
});

typedef UserResource = ({
  String? id,
  String type, // "users"
  UserAttributes attributes,
  UserRelationships? relationships,
});

typedef UserCreateResource = ({
  String type, // "users"
  UserCreateAttributes attributes,
});

typedef UserAdminCreateResource = ({
  String type, // "users"
  UserAdminCreateAttributes attributes,
});

typedef UserUpdateResource = ({
  String? id,
  String type, // "users"
  UserUpdateAttributes attributes,
});

typedef UserAdminUpdateResource = ({
  String? id,
  String type, // "users"
  UserAdminUpdateAttributes attributes,
});

typedef UserAuthResource = ({
  String type, // "auth"
  UserAuthAttributes attributes,
});

typedef UserResourceDocument = ({
  ({String version}) jsonapi,
  Map<String, dynamic>? meta,
  Map<String, dynamic>? links,
  UserResource data,
});

typedef UserCollectionDocument = ({
  ({String version}) jsonapi,
  Map<String, dynamic>? meta,
  Map<String, dynamic>? links,
  List<UserResource> data,
});

typedef UserCreateResourceDocument = ({
  ({String version}) jsonapi,
  Map<String, dynamic>? meta,
  Map<String, dynamic>? links,
  UserCreateResource data,
});

typedef UserAdminCreateResourceDocument = ({
  ({String version}) jsonapi,
  Map<String, dynamic>? meta,
  Map<String, dynamic>? links,
  UserAdminCreateResource data,
});

typedef UserUpdateResourceDocument = ({
  ({String version}) jsonapi,
  Map<String, dynamic>? meta,
  Map<String, dynamic>? links,
  UserUpdateResource data,
});

typedef UserAdminUpdateResourceDocument = ({
  ({String version}) jsonapi,
  Map<String, dynamic>? meta,
  Map<String, dynamic>? links,
  UserAdminUpdateResource data,
});

typedef UserAuthResourceDocument = ({
  ({String version}) jsonapi,
  Map<String, dynamic>? meta,
  Map<String, dynamic>? links,
  UserAuthResource data,
});
