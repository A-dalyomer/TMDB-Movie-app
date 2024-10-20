import '../../domain/entity/production_company.dart';

class ProductionCompanyModel extends ProductionCompany {
  const ProductionCompanyModel({
    required super.id,
    required super.name,
    required super.country,
  });

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyModel(
      id: json['id'],
      name: json['name'],
      country: json['origin_country'],
    );
  }
}
