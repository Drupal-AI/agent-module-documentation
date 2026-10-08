A submodule of Font Awesome that replaces the text autocomplete with a visual iconpicker widget for `fontawesome_icon` fields.

---

The iconpicker widget submodule adds a field widget (`fontawesome_iconpicker_widget`) that extends the base Font Awesome icon widget but swaps the plain autocomplete for a graphical iconpicker, letting editors browse and click icons instead of typing names. It requires the parent Font Awesome module and reuses its icon metadata via an `IconManagerService`. The JavaScript iconpicker library is loaded as a Drupal library and can be fetched locally with a dedicated Drush command (`fa:download-iconpicker`). Because it subclasses the core widget, all advanced per-icon options (size, rotation, animation, transforms) remain available and continue to respect the parent module's permission. Select it as the field widget under Manage form display for any Font Awesome icon field. It is purely an editorial-UX enhancement over the base module.

---

- Give editors a visual, clickable iconpicker instead of typing icon names.
- Browse the full Font Awesome catalog while filling a field.
- Preview icons before selecting them.
- Enable the iconpicker per field via Manage form display.
- Keep all advanced per-icon settings (size, rotate, animate) from the base widget.
- Respect the base module's advanced-settings permission.
- Download the iconpicker JS library locally with `drush fa:download-iconpicker`.
- Serve the iconpicker assets from a local library for offline use.
- Speed up icon selection for non-technical content authors.
- Reduce typos from manual icon-name entry.
- Reuse the parent module's cached icon metadata.
- Use on any entity type that has a Font Awesome icon field.
- Swap between text and picker widgets without changing stored data.
- Provide a friendlier UX for large icon sets.
- Standardize icon selection across an editorial team.
