---
layout: default
---

<h2>{{ site.description }}</h2>
<ul>
    {% for post in site.posts %}
  	<li>
        <h3>
  		    <a href="{{ post.url }}">{{ post.title }}</a>
        </h3>
        <p class="text-red-500 text-3xl font-bold">Date added: {{ post.date | date: "%-d %B %Y" }}</p>
        <p>By <a href="{{ post.creator_url }}">{{ post.creator }}</a></p>
        <p>Category: {{ post.categories }}</p>
        <p> Tags:
            {% for tag in post.tags %}
                {{ tag }}
            {% endfor %}
         </p>
	</li>
    {% endfor %}
</ul>