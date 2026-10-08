PapaParse registers the third-party PapaParse JavaScript CSV-parsing library (v5.3.0) as a Drupal asset library named `papaparse` so other modules and themes can depend on it.

---

PapaParse is a small library-wrapper module. It contains no PHP — only `papaparse.info.yml` and `papaparse.libraries.yml`. The `.libraries.yml` declares one asset library, `papaparse/papaparse`, that pulls in the well-known PapaParse client-side CSV parser (a fast in-browser CSV reader/writer with worker-thread, streaming and header-detection support). It provides no functionality of its own: it does not parse anything, expose routes, permissions, config or services. Its only job is to make the `Papa` global available on the page so your own JavaScript (attached through a module or theme that depends on this library) can call `Papa.parse()` / `Papa.unparse()`. You enable it when another module lists `papaparse/papaparse` as a dependency, or when you are writing custom JavaScript that needs client-side CSV parsing.

---

- Enable the module so the `papaparse/papaparse` asset library becomes available to depend on.
- Add `papaparse/papaparse` to your module's or theme's `*.libraries.yml` as a dependency of your own library.
- Attach it from a render array with `$build['#attached']['library'][] = 'papaparse/papaparse';`.
- Attach it from a theme by declaring a `libraries-dependency` or listing it in `libraries` in the `.info.yml`.
- Parse an uploaded CSV file in the browser with `Papa.parse(file, {...})` before submitting a form.
- Parse a pasted CSV string client-side with `Papa.parse(csvString)`.
- Stream and parse a large remote CSV with `Papa.parse(url, { download: true, step: ... })` without loading it all into memory.
- Auto-detect a header row with the `header: true` option to get an array of row objects.
- Auto-detect the delimiter (comma, tab, semicolon, pipe) via PapaParse's delimiter guessing.
- Offload parsing of a big file to a Web Worker with the `worker: true` option to keep the UI responsive.
- Serialize a JavaScript array/objects back to CSV text with `Papa.unparse(data)`.
- Build a client-side CSV import/preview widget without shipping your own parser.
- Give a Views or field UI a live client-side CSV preview.
- Validate CSV structure in the browser before an AJAX upload.
- Back a custom bulk-import screen where the browser reads and chunks the CSV.
- Share one vetted copy of PapaParse across several modules so they do not each bundle their own.
- Pin the whole site to PapaParse 5.3.0 through a single declared library.
- Keep the module disabled when nothing on the site needs client-side CSV parsing.
- Enable it only on the environments/sites that actually use a CSV-consuming feature.
- Use it as the shared dependency for a suite of related CSV import/export modules you maintain.
- Reference it from a custom Drupal Behavior (`Drupal.behaviors`) that wires up a file input to PapaParse.
