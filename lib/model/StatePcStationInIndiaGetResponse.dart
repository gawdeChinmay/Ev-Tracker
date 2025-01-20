import 'dart:convert';

class EVChargingStationsResponse {
  final String indexName;
  final String title;
  final String description;
  final String orgType;
  final List<String> organizations;
  final List<String> sectors;
  final String source;
  final String catalogUuid;
  final String visualizable;
  final String active;
  final int created;
  final int updated;
  final String createdDate;
  final String updatedDate;
  final int externalWs;
  final String? externalWsUrl;
  final TargetBucket targetBucket;
  final List<Field> fields;
  final String message;
  final String version;
  final String status;
  final int total;
  final int count;
  final String limit;
  final String offset;
  final List<Record> records;

  EVChargingStationsResponse({
    required this.indexName,
    required this.title,
    required this.description,
    required this.orgType,
    required this.organizations,
    required this.sectors,
    required this.source,
    required this.catalogUuid,
    required this.visualizable,
    required this.active,
    required this.created,
    required this.updated,
    required this.createdDate,
    required this.updatedDate,
    required this.externalWs,
    this.externalWsUrl,
    required this.targetBucket,
    required this.fields,
    required this.message,
    required this.version,
    required this.status,
    required this.total,
    required this.count,
    required this.limit,
    required this.offset,
    required this.records,
  });

  factory EVChargingStationsResponse.fromJson(Map<String, dynamic> json) {
    return EVChargingStationsResponse(
      indexName: json['index_name'],
      title: json['title'],
      description: json['desc'],
      orgType: json['org_type'],
      organizations: List<String>.from(json['org']),
      sectors: List<String>.from(json['sector']),
      source: json['source'],
      catalogUuid: json['catalog_uuid'],
      visualizable: json['visualizable'],
      active: json['active'],
      created: json['created'],
      updated: json['updated'],
      createdDate: json['created_date'],
      updatedDate: json['updated_date'],
      externalWs: json['external_ws'],
      externalWsUrl: json['external_ws_url'],
      targetBucket: TargetBucket.fromJson(json['target_bucket']),
      fields: List<Field>.from(json['field'].map((x) => Field.fromJson(x))),
      message: json['message'],
      version: json['version'],
      status: json['status'],
      total: json['total'],
      count: json['count'],
      limit: json['limit'],
      offset: json['offset'],
      records:
          List<Record>.from(json['records'].map((x) => Record.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index_name': indexName,
      'title': title,
      'desc': description,
      'org_type': orgType,
      'org': organizations,
      'sector': sectors,
      'source': source,
      'catalog_uuid': catalogUuid,
      'visualizable': visualizable,
      'active': active,
      'created': created,
      'updated': updated,
      'created_date': createdDate,
      'updated_date': updatedDate,
      'external_ws': externalWs,
      'external_ws_url': externalWsUrl,
      'target_bucket': targetBucket.toJson(),
      'field': fields.map((x) => x.toJson()).toList(),
      'message': message,
      'version': version,
      'status': status,
      'total': total,
      'count': count,
      'limit': limit,
      'offset': offset,
      'records': records.map((x) => x.toJson()).toList(),
    };
  }
}

class TargetBucket {
  final String index;
  final String type;
  final String field;

  TargetBucket({
    required this.index,
    required this.type,
    required this.field,
  });

  factory TargetBucket.fromJson(Map<String, dynamic> json) {
    return TargetBucket(
      index: json['index'],
      type: json['type'],
      field: json['field'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'type': type,
      'field': field,
    };
  }
}

class Field {
  final String id;
  final String name;
  final String type;

  Field({
    required this.id,
    required this.name,
    required this.type,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }
}

class Record {
  final String? serialNumber;
  final String stateOrUt;
  final double pcsCount;

  Record({
    this.serialNumber,
    required this.stateOrUt,
    required this.pcsCount,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      serialNumber: json['sl__no_'],
      stateOrUt: json['state__ut'],
      pcsCount: (json['no__of_pcs_as_on_31st_march_2024'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sl__no_': serialNumber,
      'state__ut': stateOrUt,
      'no__of_pcs_as_on_31st_march_2024': pcsCount,
    };
  }
}
