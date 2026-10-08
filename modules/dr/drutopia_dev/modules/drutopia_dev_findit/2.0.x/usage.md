<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Dev for the "Find It" install profile is a submodule of Drutopia Dev that wires up Find It content and Features tooling and installs the Drutopia Features bundle for feature-building on a Find It site.

---

`drutopia_dev_findit` ships only metadata and one config file. `drutopia_dev_findit.info.yml` declares dependencies on the Find It content features (`drutopia_findit_organization`, `drutopia_findit_program`), the generic `drutopia_page` feature, core `dblog`, `node`, and `user`, and — crucially — the `features` and `features_ui` modules, so a feature-builder gets the Features UI available. `drutopia_dev_findit.features.yml` (`bundle: drutopia`, `required: true`) marks it as a required part of the `drutopia` Features bundle, and `config/install/features.bundle.drutopia.yml` installs that bundle definition. That bundle file is byte-for-byte identical to the one shipped by the parent `drutopia_dev`; the submodule's README states the two are therefore mutually exclusive (only one may install the shared config object) and that the submodule does not require — and is separate from — the parent. Its `info.yml` still carries the legacy `core: 8.x` key alongside `core_version_requirement: ^8 || ^9 || ^10`. Like its parent it is documented here from a development checkout with no packaged `version:`.

---
- Set up a feature-building environment on a Find It (`drutopia_findit`) install profile.
- Pull in the Find It organization and program content features for development.
- Add the generic Drutopia page feature to a Find It dev site.
- Make the Features UI (`features`, `features_ui`) available for packaging configuration.
- Enable database logging (`dblog`) for debugging during development.
- Install the `drutopia` Features bundle so exports follow the distribution's assignment plan.
- Use it instead of the parent `drutopia_dev` when working specifically on a Find It profile.
- Avoid enabling both this submodule and `drutopia_dev` (they ship the same bundle config).
- Package Find It configuration into features from the Features UI.
- Provide a consistent Find It contributor baseline in one enable.
- Keep Find It dev dependencies grouped behind a single module.
- Bootstrap a Find It Features workflow on a new checkout.
- Test Find It organization/program content types during feature development.
- Standardize the Features bundle used when exporting Find It config.
- Strip the Find It dev toolkit by uninstalling this one submodule.
- Document the intended dev-only, Find-It-specific scope of this submodule.
