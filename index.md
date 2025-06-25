---
layout: default
---
<script src="https://cdn.jsdelivr.net/npm/algoliasearch@5.29.0/dist/lite/builds/browser.umd.js" integrity="sha256-9bjIp+g5sHc0eN8sdDKhzQauBs20mxnuDpApe4C9Ctg=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/instantsearch.js@4.79.0/dist/instantsearch.production.min.js" integrity="sha256-FOU2owonNoOmNxF4I8jLR4D8w/vziYNi64GUN2boXRQ=" crossorigin="anonymous"></script>

<div>
    <div class="flex flex-col gap-2 py-4 lg:px-24">
        <div id="search-box"></div>
        <div id="search-poweredby" class=""></div>
    </div>
    <div id="hits" class="grid grid-cols-3 gap-4 py-8"></div>
</div>

<script>
const { liteClient: algoliasearch } = window['algoliasearch/lite'];
const searchClient = algoliasearch('SNYK0RFNCF', '5c4f681a01931daa54a1008a3429e684');
const { poweredBy } = instantsearch.widgets;

const makeHits = instantsearch.connectors.connectHits(
  function renderHits({ items, widgetParams }, isFirstRendering) {
    const container = document.getElementById(widgetParams.container);
    
    if (items.length > 0) {
        container.innerHTML = (items.map(item =>
            `<div class="md:col-span-1 col-span-3 card shadow-sm card-border flex flex-col h-full hover:shadow-xl p-4 bg-white">
                <div class="flex-1 flex flex-col">
                    <a href="${item.url}" class="flex-1 flex flex-col no-underline text-current">
                        <div class="card-body flex-1 flex flex-col">
                            <h2 class="text-2xl font-black">${item.title}</h2>
                            <p>Date added: ${new Date(item.date * 1000).toLocaleDateString('en-GB', {
                                day: 'numeric',
                                month: 'long',
                                year: 'numeric'
                              })}
                            </p>
                            <p>Category: ${item.categories}</p>
                            <div class="flex w-fit gap-2">
                                ${item.tags.map(
                                  (tag, _) =>
                                    `<span class="badge badge-secondary">${tag}</span>`
                                    )
                                    .join('')
                                }
                            </div>
                        </div>
                    </a>
                </div>
                <div class="card-actions px-4 mt-2">
                    <a class="badge flex items-center gap-1" href="{{ post.creator_url }}" target="_blank" rel="noopener">
                        posted by ${item.creator}
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-3 h-3 inline" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 13v6a2 2 0 01-2 2H6a2 2 0 01-2-2V8a2 2 0 012-2h6m5-3h3m0 0v3m0-3L10 14" />
                        </svg>
                    </a>
                </div>
            </div>`
            )).join('');
        } else {
            container.innerHTML = `
              <div class="text-gray-500 text-center py-4 col-span-full">
                No items found.
              </div>
            `;
          }
  }
);

const search = instantsearch({
  indexName: '{{ site.algolia.index_name }}',
  searchClient,
});

search.addWidgets([
  makeHits({
    container: 'hits'
  }),

  instantsearch.widgets.searchBox({
    showReset: false,
    showSubmit: false,
    placeholder: "Search among {{ site.posts.size }} items",
    cssClasses: {
        root: 'SearchBoxInputRoot',
        input: 'SearchBoxInput'
    },
    container: '#search-box',
  }),

  instantsearch.widgets.poweredBy({
    container: '#search-poweredby',
  }),
]);

search.start();
</script>
