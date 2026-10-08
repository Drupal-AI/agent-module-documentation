# Configuration

OAI-PMH LAC offers **no configuration form of its own**. What it contributes is the
LAC metadata mapping (`oai_lac`) and the metatags that feed it. The actual
configuration happens in the two modules it depends on: **REST OAI-PMH** (which
serves the endpoint) and **Metatag** (which supplies the Dublin Core field values).

## Configure the OAI-PMH endpoint (REST OAI-PMH)

Use the **REST OAI-PMH** module's UI to set up the endpoint and which content it
exposes:

1. Go to the REST OAI-PMH configuration (under **Configuration → Web services**).
2. Define the OAI-PMH **sets** and mappings that determine which content and view
   modes are exposed, selecting the LAC metadata mapping this module provides where
   applicable.
3. Save, and note the endpoint URL harvesters (including LAC) will use.

Consult the REST OAI-PMH module's own documentation for the details of its forms.

## Configure the Dublin Core values (Metatag)

Use the **Metatag** UI to populate the Dublin Core metatags that the LAC mapping
draws from:

1. Go to **Configuration → Search and metadata → Metatag**.
2. Edit the relevant metatag defaults (or per‑bundle overrides) and set the Dublin
   Core fields, using **tokens** to pull values from your content and Islandora
   metadata.
3. Save.

## Public‑metadata review

Because OAI-PMH endpoints are meant to be **publicly harvestable**, treat everything
the feed exposes as public:

- Include only **published / public** content's metadata in the exposed sets.
- Review the Dublin Core fields for anything sensitive before turning the feed on.
- Confirm the endpoint returns what you expect by requesting it and inspecting the
  XML.

## Verify

Request your OAI-PMH endpoint (for example a `ListRecords` request with the LAC
metadata prefix) and confirm the Dublin Core records come back correctly populated
and in the `oai_lac` shape LAC expects.
