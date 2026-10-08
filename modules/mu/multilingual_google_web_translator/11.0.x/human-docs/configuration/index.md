# Configuration

There are two small steps to get the translator working: choose which languages to
offer in the dropdown, and place the block where visitors will see it. No API key or
credential is involved — the widget runs client‑side in the visitor's browser.

## 1. Choose the languages to offer

1. Log in as a user with permission to administer site configuration.
2. Open the module's settings form at route
   `multilingual_google_web_translator.settings` (via the module's *Configure* link
   on the **Extend** page).
3. **Select the languages** you want to appear in the front‑end dropdown. English is
   the default source language; the languages you pick are what visitors can
   translate the page into.
4. **Save** the form.

## 2. Place the translator block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** for the region where you want the selector — the **Header**
   region is recommended so it appears on every page and is available to all
   visitors.
3. Choose the **Google Translation Block**, set its visibility if needed, and
   **Save block**.

## Using it

On the front end, visitors see a select box (defaulting to English). When they pick
another language, Google's client‑side widget translates the current page's content
into that language.

## Privacy note

Because translation happens through Google's client‑side widget, the page content a
visitor views is **processed by Google's service**. This is a machine‑translation
display convenience — there are no translated URLs, no SEO benefit, and no editorial
control over the wording. Disclose this data handling to your visitors (for example
in your privacy policy) as appropriate for your audience and jurisdiction.
