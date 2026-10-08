# Configuration

SEO Studio's previews are powered by an external preview service, so the one thing
you need to configure is the **API key** that connects to it.

## Open the settings form

1. Log in as an administrator.
2. Navigate to **`/admin/config/search/flaregpt/metatags`** (route
   `seostudio.settings`).

## Enter the API key

On the settings form, enter the **API key** for the SEO Studio preview service.
This key authenticates your site with the external service that renders the
search-engine and social previews.

Because it is a credential for a third-party service, **treat the API key as a
secret**: keep it out of anything publicly visible, and if your workflow supports
it, prefer supplying the value through a secure mechanism (such as an environment
variable or the Key module) rather than pasting secrets somewhere they might be
committed or exported in plain text.

## Save and preview

Save the form. Then open any node, click its **SEO** tab (or visit
`/node/{node}/seo`), and you should see live previews of the search-result
snippet and the Facebook / Open Graph and Twitter/X cards, along with a **Raw
metatags** fieldset showing the node's actual meta tag output. Refine your titles,
descriptions, and images through Metatag until the previews look the way you want.
