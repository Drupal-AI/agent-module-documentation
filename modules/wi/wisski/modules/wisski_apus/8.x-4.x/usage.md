<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI APUS is the base for content and annotation processing — the framework the triplification and merge processors build on.

---

APUS provides the shared machinery for processing WissKI content: taking records or text, running them through processors, and producing annotations or transformed data. `wisski_triplify` and `wisski_merge` are the processors that ship nested under it.

The processing model matters in a research context because a lot of the value in a collection is locked in prose. A catalogue entry is a paragraph of expert description; extracting the entities, dates and places it mentions turns that paragraph into queryable data without a cataloguer retyping it. That is what an annotation pipeline is for.

**This module ships under the project's `legacy/` directory**, which is the important operational fact. Its nested processors do not, so the family is partly current and partly not — establish what a project actually depends on before building new work here, and check the project's own documentation for the current processing path.

---

- Process content through a pipeline.
- Produce annotations from text.
- Extract entities from catalogue prose.
- Turn expert description into queryable data.
- Run a transformation over records.
- Build a custom processor.
- Chain processors together.
- Understand APUS's role in the family.
- Check its legacy status before adopting.
- Establish what a project depends on.
- Find the current processing path.
- Combine annotation with triplification.
- Audit processing pipelines on a project.
- Plan text-to-data extraction.
- Document this module's role for the project.
- Review its status during an audit.
