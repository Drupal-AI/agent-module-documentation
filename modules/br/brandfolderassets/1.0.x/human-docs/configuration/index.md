# Configuration

There are two parts to setting up Brandfolder Assets: the connection (which lives
in the **Brandfolder** module) and this module's own display options and field.

## 1. Configure the Brandfolder connection first

Brandfolder Assets does not hold its own API key — it reuses the one from the
**Brandfolder** module. In that module, set the Brandfolder API key and default
brandfolder/collection. Keep that API key out of exported config and code: store
it in an environment variable and reference it (via a Key entity where possible),
as described in the Brandfolder module's configuration guide.

## 2. The Brandfolder Assets settings form

The module's own settings are at **Configuration → Media → Brandfolder Assets**
(`/admin/config/media/brandfolderassets`). This is a small form that controls the
picker's appearance:

- **Show the asset title** in the popup.
- **Show the asset extension** in the popup.
- **The insert-button label** used in the widget.

These are display preferences only — they do not affect the connection or which
assets are available.

## 3. Add the field to a content type

Use the **Field UI** to add a **Brandfolder Assets** field to a content type
(Structure → your content type → Manage fields → Add field). Configure its widget
(the picker) on the form display and its formatter on the view display. When
editors add content, the field opens the Brandfolder library modal; selecting an
asset downloads it into your site's files (under `public://brandfolderassets`) as
a managed file.
