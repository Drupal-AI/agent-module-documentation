# Configuration

Setting up Textarea Limit is two steps: set a global limit on the settings page,
then turn the limit on for each textarea widget you want to constrain.

## 1. Set the global limit

1. Go to **Configuration → Content authoring → Textarea Limit**
   (`/admin/config/content/textarea-limit`). You need the
   `administer textarea_limit` permission to open it (grant it on
   **People → Permissions** — it is a dedicated permission, so an editorial lead
   can manage limits without full site-configuration rights).
2. Set the **global character limit** here. This is the default used by any
   widget that opts into limiting without specifying its own number.
3. Save.

## 2. Turn on the limit for a widget

The limit applies to the textarea widgets you select on their form-display
settings:

1. Add or locate a textarea field on the entity of your choice (for example a
   summary or teaser field on a content type).
2. Go to that content type's **Manage form display**.
3. For the textarea field, open its widget formatting options (the gear icon) and
   enable the character limit. You can either:
   - **use the global text limit** set above, or
   - **set a custom limit** for this specific field.
4. Save.

## Result

Open the create/edit form for the entity and look at the textarea field — it now
shows how many characters are left and stops the editor at the limit.

## Remember: this is an editorial aid, not hard validation

The counter runs in the browser, so it guides someone typing in the form but does
not enforce the limit on writes that skip the JavaScript — a programmatic save, a
content import, or a REST/JSON:API request. If the limit must be guaranteed, add
a server-side length constraint on the field as well. And do not run Textarea
Limit and the **`maxlength`** module on the same widget — choose one.
