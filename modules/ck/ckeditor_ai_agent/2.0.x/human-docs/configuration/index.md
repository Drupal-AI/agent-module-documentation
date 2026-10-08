# Configuration

Getting CKEditor AI Agent working end to end involves four places: the AI
module's provider settings, this module's own settings form, the permissions
page, and your text formats. Take them in order.

## 1. Configure a default AI provider

The AI Agent does not talk to any provider directly — it uses whatever the **AI
module** has configured. Go to **Configuration → AI → Settings**
(`/admin/config/ai/settings`) and set a **default Chat provider** (for example
OpenAI or DXPR), making sure that provider has valid credentials. If you followed
the [installation](../installation/index.md#storing-the-provider-api-key-safely)
guidance, its API key comes from a Key entity backed by an environment variable.

## 2. Configure the AI Agent settings

Go to **Configuration → Content authoring → CKEditor AI Agent**
(`/admin/config/content/ckeditor-ai-agent`). This global settings form lets you
set the site-wide defaults for AI generation — most importantly a **default
model** to use when a request does not name one. The client may request a
specific model per generation, but the value is validated and only overrides the
configured default; there is no arbitrary-URL or free-form endpoint proxying.

## 3. Grant permissions (deliberately)

Go to **People → Permissions** and grant **Use CKEditor AI Agent** to the roles
that should be able to generate content. There is also an **Administer CKEditor AI
Agent** permission, which is marked *restricted* — keep it to trusted
administrators.

> **Cost warning.** Anyone with *Use CKEditor AI Agent* can send arbitrary
> prompts through your provider account, and can pick a more expensive model than
> the default. The module does not rate-limit or budget. Grant the permission
> only to roles that genuinely need it, monitor your provider's usage dashboard,
> and set spend limits on the provider side.

## 4. Add the button to your text formats

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), **Configure** a CKEditor 5 format, and drag
the **AI Agent** button into the *Active toolbar*. Save.

## Using it

Editors can now, in that format:

- Type `/` in an empty field to open the AI command menu, then a command such as
  `/write blog about AI`.
- Press **Cmd/Ctrl + /** to force-insert a slash command mid-text.
- Select text and use the AI menu to rewrite, review, fix errors, or adjust tone.
- Press **Cmd/Ctrl + Backspace** to cancel a generation in progress.

Generated content streams into the document as it is written, and the module
formats the output to match the editor's allowed content.

## How the request is handled (for the security-minded)

Requests go to a server-side proxy that is POST-only, requires the *Use CKEditor
AI Agent* permission, and is CSRF-protected — so a third-party page cannot drive
it with a logged-in editor's session. The provider credential stays on the
server and is never exposed to the browser. The remaining consideration is cost,
covered above, not compromise.
