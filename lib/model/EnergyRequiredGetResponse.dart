class EnergyRequirementResponse {
  String? indexName;
  String? title;
  String? desc;
  String? orgType;
  List<String>? org;
  List<String>? sector;
  String? source;
  String? catalogUuid;
  String? visualizable;
  String? active;
  int? created;
  int? updated;
  String? createdDate;
  String? updatedDate;
  int? externalWs;
  String? externalWsUrl;
  TargetBucket? targetBucket;
  List<Field>? field;
  String? message;
  String? version;
  String? status;
  int? total;
  int? count;
  String? limit;
  String? offset;
  List<Record>? records;

  EnergyRequirementResponse({
    this.indexName,
    this.title,
    this.desc,
    this.orgType,
    this.org,
    this.sector,
    this.source,
    this.catalogUuid,
    this.visualizable,
    this.active,
    this.created,
    this.updated,
    this.createdDate,
    this.updatedDate,
    this.externalWs,
    this.externalWsUrl,
    this.targetBucket,
    this.field,
    this.message,
    this.version,
    this.status,
    this.total,
    this.count,
    this.limit,
    this.offset,
    this.records,
  });

  factory EnergyRequirementResponse.fromJson(Map<String, dynamic> json) {
    return EnergyRequirementResponse(
      indexName: json['index_name'],
      title: json['title'],
      desc: json['desc'],
      orgType: json['org_type'],
      org: (json['org'] as List<dynamic>?)?.map((e) => e as String).toList(),
      sector:
          (json['sector'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
      targetBucket: json['target_bucket'] != null
          ? TargetBucket.fromJson(json['target_bucket'])
          : null,
      field: (json['field'] as List<dynamic>?)
          ?.map((e) => Field.fromJson(e))
          .toList(),
      message: json['message'],
      version: json['version'],
      status: json['status'],
      total: json['total'],
      count: json['count'],
      limit: json['limit'],
      offset: json['offset'],
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => Record.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index_name': indexName,
      'title': title,
      'desc': desc,
      'org_type': orgType,
      'org': org,
      'sector': sector,
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
      'target_bucket': targetBucket?.toJson(),
      'field': field?.map((e) => e.toJson()).toList(),
      'message': message,
      'version': version,
      'status': status,
      'total': total,
      'count': count,
      'limit': limit,
      'offset': offset,
      'records': records?.map((e) => e.toJson()).toList(),
    };
  }
}

class TargetBucket {
  String? index;
  String? type;
  String? field;

  TargetBucket({this.index, this.type, this.field});

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
  String? id;
  String? name;
  String? type;

  Field({this.id, this.name, this.type});

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
  String? years;
  int? energyRequirement;

  Record({this.years, this.energyRequirement});

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      years: json['years'],
      energyRequirement: json['energy_requirement'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'years': years,
      'energy_requirement': energyRequirement,
    };
  }
}
