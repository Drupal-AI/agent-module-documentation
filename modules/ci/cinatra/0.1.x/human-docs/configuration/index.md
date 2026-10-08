# Configuration

Getting Cinatra running takes two steps: connecting your site to a Cinatra
instance, and giving the right editors permission to use the assistant.

## 1. Connect to your Cinatra instance

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Cinatra**
   (`/admin/config/services/cinatra`).
3. Enter your **Cinatra instance address** (the web address of the instance you
   host or have access to).
4. Click **Connect with Cinatra**. You'll be taken to a screen where you **approve
   the connection**. Once you approve, the integration credential is provisioned
   and stored on your server automatically — you never copy or paste a key.

> **No redirect in your setup?** If your environment can't do the browser redirect
> handshake, use the fallback: paste the one-line **connection code** (install
> code) into the form, or use the **Manual configuration** section on the same
> settings page.

Behind the scenes the connection is hardened: the credential stays server-side and
is never sent to your browser, the return leg is protected by a single-use,
user-bound `state` plus PKCE, and the server's calls to your instance are screened
by an SSRF guard. There's nothing you need to do for this — it's just why the flow
is a redirect-and-approve rather than a paste-your-API-key form.

### Containerized / custom topology

If your instance is reached at a different internal address (for example in a
containerized setup), the module supports a validated base-URL override. Use it only
if your topology requires it.

## 2. Grant the assistant permission

The assistant appears **only** for users who have the right permission:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **"Use the Cinatra AI assistant"** and tick it for the roles of the content
   editors who should see the assistant.
3. **Save permissions.**

> Grant this only to people you trust to edit content — the assistant can read the
> current page and propose changes to it.

## 3. Try it

As a user with the permission, open a node page, a node edit form, or the front
page. The Cinatra assistant panel should appear alongside the content. Ask it to
draft or rewrite something; you review each suggestion and decide what to keep, and
where your instance supports it, an accepted change can drop straight into the form.

## A note on your content

When an editor chats with the assistant, the messages they type and the page
they're on are sent to the Cinatra instance you configured — and nowhere else. That
instance's own privacy terms cover this data (see
[cinatra.ai](https://www.cinatra.ai)). If you switch to a different instance, the
module rotates the stored credential and clears webhook material for the old one.
