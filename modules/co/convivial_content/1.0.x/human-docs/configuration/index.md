# Configuration

Convivial Content works by importing default content from a source you configure.
Setup is two steps: tell it where to fetch content from, then run the import.

## Before you start

Importing requires high‑level permissions, so **always perform the import while
logged in as the site administrator**. Per the module's FAQ, importing does not work
reliably as an ordinary authenticated user.

## 1. Set the source URL

1. Make sure the module is enabled (see [Installation](../installation/index.md)).
2. Go to **Configuration → Convivial CXP → Content Import → Convivial Content**.
3. In the **Source URL** field, enter the URL to fetch the source content from.
4. Save the form.

## 2. Import the content

1. Go to **Configuration → Convivial CXP → Content Import**.
2. Select the **dataset** you want to bring in.
3. Run the import.

The example content is then created on your site.

## After importing

Treat the imported content as a **starting point**. Review each item and replace or
remove it before the site goes to production — demo content is meant to give you a
working structure to build on, not to ship as‑is. Because this module makes an
outbound request to the configured source URL, make sure your environment allows
that connection.
