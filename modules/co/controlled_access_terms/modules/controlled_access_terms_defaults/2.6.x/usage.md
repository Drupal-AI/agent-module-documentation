<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Controlled Access Terms Defaults is a config-only submodule that installs a ready-made set of archival/library authority vocabularies (person, family, corporate body, subject, geographic location, and more), each pre-configured with the parent module's fields, form and view displays, translation settings, and optional RDF mappings, so a site starts with standard authority structures already in place.

---

The parent Controlled Access Terms module supplies field types but leaves the modelling to you; this submodule provides an opinionated starting point built from those fields. Enabling it imports ten taxonomy vocabularies as bundles and attaches the appropriate fields to each: EDTF begin/end dates on agents (person, family, corporate body), an authority link on every vocabulary, a typed-relation "relationships" field carrying schema.org relations, organization-type options on corporate bodies, and geolocation plus a "broader" reference on geographic locations. Default form and view displays, content-translation settings, and (when the rdf module is present) schema.org RDF mappings are installed alongside. Because it is pure configuration, everything it creates is ordinary editable site config after install — you can adjust, extend, or delete any of it in the Taxonomy and Field UI, and uninstalling the submodule leaves the created config and terms untouched. It is intended for Islandora and ArchivesSpace-to-Drupal workflows but has no hard dependency on either.

---

- Bootstrap a person authority vocabulary with birth/death dates.
- Get a corporate-body vocabulary with founding/dissolution dates and org types.
- Install a family authority vocabulary out of the box.
- Add a subject/topic authority vocabulary.
- Add a geographic-location vocabulary with lat/long and a broader reference.
- Install genre, language, physical form, resource type, and temporal-subject vocabularies.
- Attach an authority-link field to every authority vocabulary automatically.
- Get a typed-relationships field pre-loaded with schema.org relations.
- Start cataloguing agents without hand-building fields.
- Provide default form and view displays for each authority type.
- Enable content translation for authority terms by default.
- Install schema.org RDF mappings for linked-data output.
- Map authority links to schema:sameAs and dates to birth/death properties.
- Give an ArchivesSpace import the expected target structures.
- Kickstart an Islandora repository's authority model.
- Reuse a single vocabulary's config by exporting it after install.
- Extend the shipped vocabularies with your own extra fields.
- Serve as a worked example of the parent module's field types.
