# Configuration

CKEditor 5 - Dark Mode plugin has no central settings page. You make it available
by adding its toolbar button to each CKEditor 5 text format where you want editors
to be able to switch themes.

## Add the Dark Mode button to a text format

1. Log in as a user with the **Administer filters** permission (an administrator by
   default).
2. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
3. Click **Configure** next to a text format whose editor is CKEditor 5 (for
   example *Full HTML* or *Basic HTML*).
4. In the CKEditor 5 toolbar configuration, find the **Dark Mode** button in the
   list of available buttons and drag it up into the active toolbar, positioning it
   wherever suits your editors.
5. Click **Save configuration**.

Repeat for any other text formats that should offer the dark-mode toggle.

## Using it

When editing content with that format, editors click the **Dark Mode** button to
switch the editor between light and dark themes. The toggle affects only the
editor's appearance during editing — it does not change the saved content or how
the content looks on the published page.

## Tip: pairing with colour plugins

If you use a CKEditor 5 font-colour, background-colour, or font-size/family plugin
that offers a white (or very light) text colour, add the Dark Mode button to the
same formats. Editors can then switch to the dark editor theme to see light text
that would otherwise be invisible against the default white editing background.
