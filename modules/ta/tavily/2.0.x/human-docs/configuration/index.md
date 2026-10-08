# Configuration

Setting Tavily up has two parts: telling Drupal your Tavily API key, and (if you
want the automated field‑filling) wiring an AI Automator to a field.

## 1. Add your Tavily API key

1. Log in as an administrator.
2. Go to **Configuration → Tavily → Settings**, or navigate directly to
   `/admin/config/tavily/settings`.
3. Enter the API key from your Tavily account.
4. Save the form.

Because the module uses Drupal's **Key** module, the recommended practice is to
keep the key itself in an environment variable and reference it through a Key
entity, so the secret never lands in your configuration export or version
control. Every search the module runs is sent to Tavily's servers and may count
against your Tavily plan, so treat the key as a paid credential.

## 2. Restrict who can use the tools

Use of Tavily's tools is gated by the **`use tavily tools`** permission at
**People → Permissions** (`/admin/people/permissions`). Grant it only to roles
you trust, since every use makes a billable external API call.

## 3. Wire up an AI Automator (optional)

If you have installed the AI module and its AI Automator submodule, you can have
Tavily fill fields automatically:

1. Install the [AI module](https://www.drupal.org/project/ai).
2. Create (or pick) a content type or entity type with a plain **text/string
   field** to hold the search word.
3. Add the field you want Tavily to fill — a **Link** field (to receive scraped
   URLs) or a **long string / long text** field (to receive summaries).
4. On that field, enable the **AI Automator** checkbox and choose the matching
   Tavily Automator (links from a search word, or summaries from a search word),
   then configure it to read from your search‑word field.
5. Create an entity of that type, fill in a search word, and save. Tavily runs
   the search and the target field is populated with the results.

## How the service works for developers

Beyond the Automators, any module can call the search service directly. For
example, to get third‑party information about a question:

```php
$tavily = \Drupal::service('tavily.api');

$tavily_config = [
  'search_depth' => 'basic',
  'include_answer' => TRUE,
  'exclude_domains' => [
    'https://www.drupal.org',
  ],
];

$response = $tavily->search('Why should I use Drupal', $tavily_config);
```

The response is a JSON array of answers and links. The available configuration
options mirror the Tavily REST API — see Tavily's own API documentation for the
full list.
