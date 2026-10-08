# Configuration

Configuration is about deciding **which content gets a PageMap** and **what goes into
it**. There are no API keys or secrets here — just a mapping of content types and
fields.

## Open the configuration page

1. Log in as a user with permission to administer the module.
2. Go to **Configuration → Search and metadata → PageMap**
   (`/admin/config/search/pagemap`).

## Choose content types and fields

1. **Select which content types should have a PageMap.** Only the types you pick will
   emit PageMap markup on their pages.
2. **For each selected content type, choose which fields become PageMap attributes.**
   Each mapped field adds an attribute to the PageMap for that page. (The content type
   itself can be included as one of the attributes, which is useful as a search
   filter.)
3. Save your configuration.

## Re‑index so Google picks it up

Once you've configured your PageMap embeds, the markup is added to the `html_head` of
matching pages, but Google only benefits from it after those pages are **crawled and
re‑indexed**. Allow time for re‑indexing, and if you use a Programmable Search Engine
or the Vertex AI Search module, the PageMap attributes then become available as
filters for search queries.
