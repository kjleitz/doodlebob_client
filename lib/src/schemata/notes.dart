typedef NoteAttributes = ({
  String title,
  String body,

  /// Can be parsed to a `DateTime`
  String createdAt,

  /// Can be parsed to a `DateTime`
  String updatedAt,
});

typedef NoteCreateAttributes = ({
  String? title,
  String? body,
});

typedef NoteUpdateAttributes = ({
  String? title,
  String? body,
});

typedef NoteLabelResourceLinkage = ({
  String type, // "labels"
  String id, // Normally a number in the DB, but according to JSON:API spec this MUST be a string
});

typedef NoteUserResourceLinkage = ({
  String type, // "users"
  String id,
});

typedef NoteRelationships = ({
  ({List<NoteLabelResourceLinkage> data})? labels,
  ({NoteUserResourceLinkage data})? user,
});

typedef NoteCreateRelationships = ({
  ({List<NoteLabelResourceLinkage> data})? labels,
});

typedef NoteUpdateRelationships = ({
  ({List<NoteLabelResourceLinkage> data})? labels,
});

typedef NoteResource = ({
  String? id,
  String type, // "notes"
  NoteAttributes attributes,
  NoteRelationships? relationships,
});

typedef NoteCreateResource = ({
  String type, // "notes"
  NoteCreateAttributes attributes,
  NoteRelationships? relationships,
});

typedef NoteUpdateResource = ({
  String? id,
  String type, // "notes"
  NoteUpdateAttributes attributes,
  NoteRelationships? relationships,
});

typedef NoteResourceDocument = ({
  ({String version}) jsonapi,
  Map<String, dynamic>? meta,
  Map<String, dynamic>? links,
  NoteResource data,
});

typedef NoteCollectionDocument = ({
  ({String version}) jsonapi,
  Map<String, dynamic>? meta,
  Map<String, dynamic>? links,
  List<NoteResource> data,
});

typedef NoteCreateResourceDocument = ({
  ({String version}) jsonapi,
  Map<String, dynamic>? meta,
  Map<String, dynamic>? links,
  NoteCreateResource data,
});

typedef NoteUpdateResourceDocument = ({
  ({String version}) jsonapi,
  Map<String, dynamic>? meta,
  Map<String, dynamic>? links,
  NoteUpdateResource data,
});
