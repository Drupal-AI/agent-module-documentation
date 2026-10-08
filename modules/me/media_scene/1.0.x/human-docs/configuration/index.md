# Configuration

Media Scene has two configuration steps. The first — adding the toolbar buttons to
your text formats — is **required** before editors can create scenes. The second —
choosing an image style on the settings page — is **optional** tuning.

## Step 1 (required): add the buttons to a text format

1. Log in as a user who can administer text formats (an administrator by default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit the text format you want to support
   scenes.
3. In the CKEditor 5 toolbar configuration, drag these three buttons from
   **Available buttons** up into the **Active toolbar**:
   - **Add Background Image**
   - **Background Scene Settings**
   - **Remove Background Image**
4. If this text format uses the **Limit allowed HTML tags** filter, also tick the
   **Render Media Scene backgrounds** filter. This is what allows the stored
   background markup to render when HTML filtering is on — without it, scenes will
   not display. Formats that use **Full HTML** (no tag restriction) work without
   this filter.
5. Click **Save configuration**.

No further configuration is required to begin creating scenes.

## Step 2 (optional): choose an image style

An optional settings page lets administrators pick an **image style** applied to
all background images — useful for optimizing large hero images and reducing
bandwidth.

1. Go to **Configuration → Media → Media Scene**
   (`/admin/config/media/media-scene`). This page is protected by the
   **Administer Media Scene** permission.
2. Select an **image style** for backgrounds. If you leave it unset, the original
   uploaded image is used at full size.
3. Save.

Because backgrounds reference the media entity rather than a fixed URL, changing the
image style here updates every existing scene the next time it renders.

## Permissions

- Editors need only Drupal's standard **View media** permission to add, configure,
  and remove backgrounds with the toolbar buttons.
- The optional settings page above is gated by the **Administer Media Scene**
  permission, which you should grant only to administrators at **People →
  Permissions** (`/admin/people/permissions`).
