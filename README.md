# WavyNews

### Setup

```
ruby  3.1.1
rails 7.0.4

after bundle'ing...

rake db:create db:migrate
rake stories:repopulate_top10_stories
```

### Info

Provides the top 10 stories from HackerNews' API. Only `story` related objects, and their comments. Not `job`s or any other types.

The quick relation of how everything is setup is:

```
a Story has many Comments
Comments act as a Tree structure

                    [comment]
                   /
          [comment]
         /         \
        /           [comment]---[comment]
[story]
        \
         \
          [comment]---[comment]
```

Comments are not populated until visited. I wanted to take in the number of HTTP requests that could potential occur, and not want either rate limit myself, or have very long load times.

Starting at Stories, if a User were to visit that Story, it then fetches the top level Comments. If a Comment has further levels, upon visiting, those are fetched/loaded. This logic is represented in their associated controller/model and in `app/models/application_record.rb`.

One semi-downfall of this is the first level comments, I've noticed, can potentially be a fair amount (more than 10). While sub-levels seem to be less, that first level could maybe benefit frmo some sort of pagination.

### Important files:

```
# lib for HackerNewsApi
app/lib/hacker_news.rb

# models for Stories/Comments
app/models/story.rb
app/models/comment.rb

# Repopulation of Stories every hour
lib/tasks/stories/repopulate_stories_task.rake
```

### Testing

Testing is done in `rspec`.

Controllers are tested quite thoroughly, as is the HN Reponse.

Everything else revolves around the HN API a didn't test too much of the mocking of the API as I would be testing the responses from HN, which can be time intensive using stubs.

Given more time, I would like to write tooling/monitoring/end-to-end around HN's API for this.

e.g. "What if HN changes their response?"

### Scheduled job

Refer to `config/schedule.rb`, and the `wheneverize` gem. On Heroku, this is using the Heroku Scheduler as is run every hour. It utilizes the above rake task.

### Hiccups

I ran into deleted comments late while working on this, which was interesting. It broke some repopulation logic I had, and has been accounted for.

_end_