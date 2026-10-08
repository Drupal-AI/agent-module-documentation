# Configuration

Google Books is configured as a **filter on a text format**, so all of its settings
live on the text‑format edit screen rather than on a dedicated admin page.

## Enable the filter on a text format

1. Log in as a user with the **Administer filters** permission.
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Click **Configure** next to the format you want (for example *Full HTML* or
   *Basic HTML*). Enable *Google Books* only on formats you trust, since the filter
   fetches and renders external data.
4. In the **Enabled filters** list, tick **Google Books**.

## Get the filter order right

Filters run in sequence, and order matters. In the **Filter processing order**
section, make sure Google Books runs where its output survives — for instance, do
**not** place it before a "Limit allowed HTML tags" or "Convert line breaks" filter
that would strip the markup it produces. Adjust the order until the rendered output
looks right.

## Choose which book fields to display

Expand the **Google Books** section under **Filter settings**. Here you select which
pieces of book data the filter should output — you can include or exclude individual
fields (title, author and other details), the **cover image** when one is available,
and the **Google Books preview reader** for volumes that offer a full or partial
preview. Turn off the fields you don't want cluttering the output.

## Optional: Google Books API key

The same settings area accepts a **Google Books API key**. You do not need one for
light use — without a key you get Google's default unregistered daily request
limit. If your site makes many requests per day, register a key for the **Books
API** in the Google Cloud console and paste it in to raise the limit.

> **Important:** the key must be enabled specifically for the Books API. An
> *incorrect* key causes errors in the log and no books will render — removing a bad
> key restores normal loads up to the default unregistered limit.

### Store the key securely

Treat the API key as a secret. Rather than committing it into exported
configuration, keep the value in an environment variable and inject it at runtime.
With DDEV you can store it out of version control:

```bash
ddev dotenv set .ddev/.env --google-books-api-key=<your-key>
ddev restart
```

Then reference `getenv('GOOGLE_BOOKS_API_KEY')` from `settings.php` when overriding
the filter configuration, so the secret never lands in the database export or the
repository.

## Save and test

Click **Save configuration**, then edit a piece of content that uses this format and
add a `[google_books: … ]` tag as described in
[How to use it](../index.md#how-to-use-it). Save the content and confirm the book
data renders as expected.
