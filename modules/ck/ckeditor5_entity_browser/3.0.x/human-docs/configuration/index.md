# Configuration

Setting up CKEditor Entity Browser has two parts: make sure you have at least one
working entity browser, then enable it in the CKEditor 5 link UI for the text
formats where you want it. Configuration is done per text format.

## 1. Prepare an entity browser

This module surfaces existing entity browsers in the link dialog; it does not
create one for you. You need at least one configured entity browser (from the
**Entity Browser** module) whose widget is a **View**:

1. Go to **Administration → Configuration → Content authoring → Entity browsers**
   and configure (or create) an entity browser.
2. The browser's View must include a **bulk select form** so items can be selected.
3. **Recommended:** enable **"Use field cardinality"** in the entity browser view.
   This shows radio buttons instead of checkboxes — which makes sense here, since
   you always want to insert exactly one link at a time.

## 2. Enable the entity browser in a text format's link UI

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to a text format whose editor is CKEditor 5, and make
   sure the **Link** capability is part of the toolbar.
3. In the CKEditor 5 plugin settings for that format, find this module's settings
   and **enable at least one entity browser**. You can choose which entity browsers
   are offered per text format, so different formats can expose different browsers.
4. Click **Save configuration**.

## 3. Use it

While editing content with that format, insert a link (or edit an existing one).
The link dialog now shows the entity-browser button(s) you enabled. Click one to
open the browser, search and filter for the content you want, and select it to
insert the link. It works together with other link-UI plugins such as Linkit.

## Notes and limitations

- **Only canonical entities can be inserted** at this time — the link points at the
  entity's canonical page.
- Advanced tweaks such as button weights and labels are available to developers
  through a `hook_alter`; there is no UI for those.
- Consider what the inserted link stores (a resolved URL versus a stable entity
  reference), since that determines whether links survive a later path-alias
  change.
