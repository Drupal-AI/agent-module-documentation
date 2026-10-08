# Carbon impact evaluator — manual setup guide

**Carbon impact evaluator** (`carbon_impact_evaluator`) estimates the carbon and
energy footprint of your site's pages, so you can see the environmental impact of
serving them and work to reduce it. It measures page weight and translates that into
an estimated CO2 footprint, using the **CO2.js** library from the Green Web
Foundation. It is a performance/sustainability analysis tool — it has no content or
access-control role of its own.

CO2.js offers two calculation methodologies, and you can enable either or both:

- **Sustainable Web Design** — bases the estimate on data transfer as an indicator of
  energy use, extrapolating the site's energy consumption as a fraction of the whole
  system. This gives a more detailed view of the impact tied to data traffic.
- **OneByte** — calculates CO2 emissions directly from the number of bytes
  transferred, giving a straightforward per-byte perspective on the footprint.

Once configured, you can view a running summary at
`/carbon-impact-evaluator/table`, which records the carbon emissions for the site's
pages — counting only visits made after the module was installed. A recent update
also lets it calculate emissions for entities such as Users and Taxonomies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — pick a methodology, set your hosting and
   datacentre details, and place the impact block.

## Where it lives in the admin menu

The settings form is under **Configuration → Web services → Carbon Impact Evaluator
Settings**. The results summary table lives at the front-end path
`/carbon-impact-evaluator/table`. See [Configuration](configuration/index.md) for how
to set it up and where to place the reporting block.
