# Configuration

There are two places to configure Excel export: a small global settings form, and the
options on each Views Excel export display (where most of the real configuration
lives).

## Global settings form

1. Log in as a user with the **Administer xls serialization configuration**
   permission.
2. Go to **Configuration → User interface → Xls Serialization configuration**
   (`/admin/config/user-interface/xls_serialization`).

There is one option:

- **Disable column AutoSize** — by default the module auto-sizes each column to fit its
  content, which looks tidy but is slow on very large exports. Turn this on to disable
  auto-sizing and speed those exports up.

Click **Save configuration**. The setting is stored in the
`xls_serialization.configuration` config object and applies to all Excel exports.

## Per-view Excel export options

The main configuration surface is on a Views **Excel export** display. Create a View,
add a **Data export / Excel export** display, and accept the `xlsx` (or `xls`) format.
On that display you can set:

- **Filename** — the download filename. It supports global tokens and is sent as an
  attachment (`Content-Disposition: attachment`).
- **Bold header** — make the first (header) row bold.
- **Italic header** — make the header row italic.
- **Header background color** — an RGB hex color for the header row background.
- **Header text color** — the header row's text color.
- **Conditional formatting** — up to five rules. For each, pick a field, an operator
  (equals `=` or not-equals `<>`), a value to compare against, and a background color
  that is applied to rows where the field matches.

The column **headers** themselves come from your Views field labels (falling back to
the raw field key), and each worksheet is named automatically from the view's title
(sanitized and trimmed).

Beyond the display options, the export style also controls (via its settings):

- **Output format** — `Xlsx` (the modern format, the default) or `Xls` (the legacy
  binary Excel format).
- **Strip tags** — strip HTML tags and decode entities from each value (on by default),
  so cells contain clean text.
- **Trim** — trim whitespace from each value (on by default).
- **Document metadata** — workbook properties such as creator, title, subject,
  description, keywords, category, manager, and company.

A couple of helpful behaviors are automatic: any value that begins with `=` is written
as literal text rather than being interpreted as a spreadsheet formula, and in a Views
**live preview** the export returns readable JSON instead of unreadable binary.

## Permission

At **People → Permissions**, the module defines one permission:

- **Administer xls serialization configuration** (`administer xls serialization
  configuration`) — required to reach the global settings form above. It's a trusted,
  administrative permission.

(The Views export displays and any REST resources are governed by the normal Views and
REST/serialization access controls, not by this permission.)
