# Configuration

You configure Search API Recombee through the standard Search API screens at
**Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`). The Recombee-specific connection settings live
in the server form. Remember that this backend is for **indexing only** — it does
not provide facets or searching; the companion Recombee module surfaces the
recommendations.

> **Handle the credentials and data carefully.** Store the Recombee API credentials
> as secrets rather than in exported configuration or code. Because indexed content
> and user-behavior data are sent to and stored in Recombee (a third-party
> service), obtain the consent your jurisdiction requires, disclose the data
> sharing in your privacy notices, and consider data-residency requirements.

## Create the Recombee server

1. Go to **Search API** and choose **Add server**.
2. Name the server and select the **Recombee** backend.
3. Enter your Recombee database connection details and API credentials (kept as
   secrets, per the note above). If you're indexing multiple sites into one
   Recombee database for federated recommendations, use the same database across
   those sites.
4. Save the server.

## Create and configure the index

1. Choose **Add index**, name it, and pick your data source (for example, Content).
2. Assign it to the Recombee server.
3. On the **Fields** tab, add the fields whose content should be sent to Recombee to
   improve the quality of its recommendations.
4. Index your content — the items are written into your Recombee database.

## Pair it with the Recombee module

This backend only *populates* Recombee; it doesn't display anything. Configure the
companion **Recombee** module to track users and render the recommendations that
come back from the Recombee API. The maintainers strongly recommend configuring it
so that the index this backend populates is the one driving the recommendations
shown to your visitors — otherwise you're sending data to Recombee without using
its results.

## Permissions

The module provides its own permission for administering the integration. Review it
under **People → Permissions** (`/admin/people/permissions`) and grant it only to
trusted roles, since it governs the connection to an external service holding your
content and user data.
