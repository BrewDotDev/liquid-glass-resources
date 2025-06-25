---
layout: default
---

<div>
    <div class="grid grid-cols-3 gap-4 py-8">
        {% for post in site.posts %}
        <div class="md:col-span-1 col-span-3 card shadow-sm card-border flex flex-col h-full hover:shadow-xl p-4 bg-white">
            <div class="flex-1 flex flex-col">
                <a href="{{ post.url }}" class="flex-1 flex flex-col no-underline text-current">
                    <div class="card-body flex-1 flex flex-col">
                        <h2 class="text-2xl font-black">{{ post.title }}</h2>
                        <p>Date added: {{ post.date | date: "%-d %B %Y" }}</p>
                        <p>Category: {{ post.categories }}</p>
                        <div class="flex w-fit gap-2">
                            {% for tag in post.tags %}
                            <span class="badge badge-secondary">
                                {{ tag }}
                            </span>
                            {% endfor %}
                        </div>
                    </div>
                </a>
            </div>
            <div class="card-actions px-4 mt-2">
                <a class="badge flex items-center gap-1" href="{{ post.creator_url }}" target="_blank" rel="noopener">
                    posted by {{ post.creator }}
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-3 h-3 inline" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 13v6a2 2 0 01-2 2H6a2 2 0 01-2-2V8a2 2 0 012-2h6m5-3h3m0 0v3m0-3L10 14" />
                    </svg>
                </a>
            </div>
        </div>
        {% endfor %}
    </div>
</div>
