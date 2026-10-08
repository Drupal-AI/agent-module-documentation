# Configuration

Getting EngageBay working is two steps: connect your account, then add the
embedding buttons to a text format so editors can insert forms and landing pages.

## Connect your EngageBay account

1. Log in as a user with the **Access administrator pages** permission.
2. Go to the EngageBay configuration form at **`/engagebay/configure`**.
3. Enter your **EngageBay username and password** and submit.

On success, the module authenticates with EngageBay and stores the account's
**domain**, **email**, **REST API key**, and **JS API key** in the
`engagebay.settings` configuration. To connect as a different EngageBay user
later, return to this form and re-authenticate.

> **Note.** The credentials are posted to EngageBay's login endpoint over HTTPS.

## Add the embedding buttons to a text format

The Form and Landing Page controls are CKEditor plugins, so you enable them per
text format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Choose the format your editors use (for example *Full HTML*) and click
   **Configure**.
3. In the CKEditor 5 toolbar configuration, drag the **Form** and **Landing
   Page** buttons from the available items into the active toolbar.
4. Make sure the format's filters do not strip the placeholder markup the module
   inserts, then **Save configuration**.

Access to these dialogs is tied to permission to use the text format, so only
editors who may use that format can insert EngageBay content through it.

## Insert a form or landing page

1. Edit a piece of content using a format where you enabled the buttons.
2. Click the **Form** or **Landing Page** button in the toolbar. A dialog lists
   the forms or landing pages available in your EngageBay account.
3. Choose one to insert a placeholder into the content.
4. Save and view the content — the module replaces the placeholder with the hosted
   EngageBay form or landing-page HTML fetched from EngageBay.

> **Privacy reminder.** Embedded forms collect visitor data into your EngageBay
> CRM. Because that is personal data leaving your site for a third party, disclose
> it in your privacy policy and use it in line with your data-handling
> obligations.
