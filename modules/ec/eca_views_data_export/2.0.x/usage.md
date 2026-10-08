<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Views data export lets no-code ECA models react to and rewrite each row of a Views Data Export as it is generated.

---

ECA Views data export connects the ECA (Event-Condition-Action) rules engine to the Views Data Export module. It does not start or schedule exports itself; instead, whenever views_data_export builds an export (CSV, XML, DOC, etc.), this module dispatches an ECA event once per result row via `hook_views_data_export_row_alter()`. An ECA model listening to the "Alter a row" event — optionally scoped to a specific View ID and display ID — can read the outgoing row cells and the underlying Views result, then modify the row before it is written. The bundled "Set column value" ECA action overwrites a named column with a (token-replaced) value, and the module registers `[current_row:*]` and `[current_result:*]` tokens (delegating to ECA's data-transfer-object token handling) so the current row and result are available inside any action in the model. It depends on both `eca` and `views_data_export` and adds no routes, permissions, or configuration forms of its own.

---

- Rewrite the value of a specific column in a Views Data Export CSV/XML output.
- Reformat dates or numbers in exported rows to match an external system's expectations.
- Blank out or mask a sensitive column in the exported file without changing the View.
- Add a computed value into an existing export column using ECA actions and tokens.
- Localize or translate exported cell values as each row is serialized.
- Normalize boolean/status columns (e.g. 1/0 to "Yes"/"No") in the export.
- Prefix or suffix identifiers in an exported column.
- Apply conditional row edits (ECA conditions) based on other cells in the same row.
- Scope row-alter automation to a single View by setting the View ID.
- Scope row-alter automation to a single display by setting the Display ID.
- Run the same row-alter logic across all exports by leaving View/display IDs empty.
- Read the raw Views result object for a row via the `[current_result:*]` token.
- Read the outgoing row cells via the `[current_row:*]` token.
- Set an export column from data derived elsewhere in the ECA model.
- Trigger side effects (logging, messaging) per exported row from an ECA model.
- Strip or rewrite HTML/markup left in a column before it lands in a flat file.
- Replace token placeholders in a column value at export time.
- Enrich exported rows with values fetched or computed by other ECA actions.
- Standardize column formatting across multiple exports centrally in ECA.
- Automate post-processing of Views exports without writing a custom module.
- Chain multiple "Set column value" actions to rewrite several columns per row.
- Use ECA conditions to skip edits for rows that do not match criteria.
- Adjust exported values per display when one View has several export displays.
- Integrate export row transformation into a larger ECA business-rules workflow.
