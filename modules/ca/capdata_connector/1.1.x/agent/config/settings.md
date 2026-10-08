<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & mapping form

## Install / enable
`composer require drupal/capdata_connector` (pulls `capdataopera/php-sdk:0.7.0`), then
`drush en capdata_connector`. No install hook, no default config is shipped — all mapping starts empty.

## Route & access
- Route `capdata_connector.admin_settings` → `/admin/config/services/capdata-mapping`
  (`capdata_connector.routing.yml`), form `\Drupal\capdata_connector\Form\CapDataConnectorSettingsForm`.
- Requirement: `_permission: 'administer site configuration'` (core permission; the module defines none).
- Menu link `capdata_connector.admin_settings` under `system.admin_config_services`
  (`capdata_connector.links.menu.yml`). `configure:` in `.info.yml` points here.

## Config object: `capdata_connector.settings`
A single, **schema-less** config object (no `config/schema/*` ships, so `provides_config_schema` is false).
`CapDataConnectorSettingsForm::getEditableConfigNames()` lists only this object. Keys are generated per
ontology class and property (see below). Two global keys set in `submitForm()`:
- `capdata_opera_url` — the operator's CapData IRI (e.g. `https://capdataculture.fr/graph/identifier/xxxx`),
  used as the IRI of the site's own `Collectivite` in the export.
- `capdata_connector_host` — captured automatically from `RequestStack::getCurrentRequest()->getSchemeAndHttpHost()`
  on save; used to build `/node/{id}` and `/taxonomy/term/{id}` resource URLs in the RDF.

## Class list & per-class keys
`CapDataConnectorManager::getCapDataClassesInfo()` (src/CapDataConnectorManager.php:131) returns ~28
hard-coded CapDataCulture classes, each with a `capdata_full_name`, `capdata_short_id` and a
`capdata_properties` map. Classes include: `capdata_oeuvre`, `capdata_personne`, `capdata_collectivite`,
`capdata_lieu`, `capdata_production`, `capdata_evenement`, `capdata_participation`, `capdata_auteur`,
`capdata_interpretation`, `capdata_saison`, `capdata_role`, `capdata_genreoeuvre`, `capdata_typeoeuvre`,
`capdata_categorieoeuvre`, `capdata_typeproduction`, `capdata_typepublic`, `capdata_typeevenement`,
`capdata_fonction`, `capdata_adressepostale`, `capdata_pays`, `capdata_statutjuridique`, and the
participation sub-classes (`capdata_maitriseoeuvre`, `capdata_collaboration`, `capdata_partenariat`,
`capdata_mentionproduction`, `capdata_programmation`, `capdata_historiqueproduction`, `capdata_productionprimaire`).

For each class `<c>` the form (`buildForm()`) writes:
- `<c>_include_in_export` (checkbox) — include this class in the RDF export.
- `<c>_mapping_type` (radios) — `<c>_taxo_mapping` or `<c>_content_mapping` (AJAX-driven).
- `<c>_taxonomy_dropdown` — chosen vocabulary machine name (from `getVocabularyList()`).
- `<c>_content_dropdown` — chosen content type machine name (from `getContentTypesList()`).

And per property `<p>` of the class (both a taxo and a content variant are stored):
- `<c>_taxo_<p>_fields_dropdown` / `<c>_content_<p>_fields_dropdown` — the Drupal field mapped to the property
  (from `getFieldsOptionsByTaxonomy()` / `getFieldsOptionsByContentType()`).
- `<c>_taxo_<p>_custom_processing` / `<c>_content_<p>_custom_processing` — optional value transform.
- `<c>_taxo_<p>_comments` / `<c>_content_<p>_comments` — free-text documentation note.

## Custom processing options
`getSpecialProcessingOptions($propertyKey)` (:646) offers:
- `clean_url` — validate/normalise a URL (`cleanUrl()`, uses `UrlHelper::isValid`, prefixes `https://` if needed).
- `remove_tags` — `Html::decodeEntities(strip_tags(...))`.
- `image_style__<id>` — for `image`/`media` properties, build+return the derivative URL of that image style
  (`customFieldProcessing()` → `ImageStyle::createDerivative` + `FileUrlGenerator::generateAbsoluteString`).
- `daterange_start_date` / `daterange_end_date` — for date properties, pick the start or end of a daterange field.

## AJAX callbacks
`capdataWrapperInfoCallback`, `capdataTaxonomyFieldsDropdownCallback`, `capdataContentFieldsDropdownCallback`
rebuild the mapping sub-forms when the mapping type / vocabulary / content type dropdowns change.
Form labels and help text are in French. The form attaches `capdata_connector/capdata_settingsstyles`.
