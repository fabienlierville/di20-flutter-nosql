// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/magasin.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 1526697763298090777),
      name: 'Magasin',
      lastPropertyId: const IdUid(3, 5023903627451278089),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5021872444184600610),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2518084538433909867),
            name: 'nom',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5023903627451278089),
            name: 'ville',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 1526697763298090777),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Magasin: EntityDefinition<Magasin>(
        model: _entities[0],
        toOneRelations: (Magasin object) => [],
        toManyRelations: (Magasin object) => {},
        getId: (Magasin object) => object.id,
        setId: (Magasin object, int id) {
          object.id = id;
        },
        objectToFB: (Magasin object, fb.Builder fbb) {
          final nomOffset = fbb.writeString(object.nom);
          final villeOffset = fbb.writeString(object.ville);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nomOffset);
          fbb.addOffset(2, villeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Magasin(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              nom: const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              ville:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Magasin] entity fields to define ObjectBox queries.
class Magasin_ {
  /// see [Magasin.id]
  static final id = QueryIntegerProperty<Magasin>(_entities[0].properties[0]);

  /// see [Magasin.nom]
  static final nom = QueryStringProperty<Magasin>(_entities[0].properties[1]);

  /// see [Magasin.ville]
  static final ville = QueryStringProperty<Magasin>(_entities[0].properties[2]);
}
