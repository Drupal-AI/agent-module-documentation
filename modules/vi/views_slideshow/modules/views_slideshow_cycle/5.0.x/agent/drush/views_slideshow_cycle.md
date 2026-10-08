# Drush commands — install the JS libraries

The Cycle engine needs external JavaScript libraries under `/libraries`. This submodule ships
Drush commands (`src/Commands/ViewsSlideshowCycleCommands.php`, registered via
`drush.services.yml`) that `wget` each library into place.

| Command | Aliases | Downloads to |
|---|---|---|
| `drush views:slideshow:cycle` | `dl-cycle` | jQuery Cycle → `libraries/jquery.cycle/jquery.cycle.all.js` |
| `drush views:slideshow:json2` | `dl-json2` | JSON2 → `libraries/json2/json2.js` |
| `drush views:slideshow:hoverintent` | `dl-hoverintent` | jQuery HoverIntent → `libraries/jquery.hover-intent/jquery.hoverIntent.js` |
| `drush views:slideshow:pause` | `dl-pause` | jQuery Pause → `libraries/jquery.pause/jquery.pause.js` |
| `drush views:slideshow:lib` | `dl-cycle-lib` | All four of the above |

Notes:
- jQuery Cycle is **required** for the engine to run; JSON2 unlocks the advanced raw-options
  UI; HoverIntent and Pause are optional enhancements (pause-in-middle needs Pause).
- Run from the Drupal web root so paths resolve. Each command creates the directory, downloads
  the file, and skips/notices if it already exists.
- Alternative to Drush: the Composer merge-plugin approach with the module's
  `composer.libraries.json`, or manual download (see the project README).
