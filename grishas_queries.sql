--1.Сторона(radiant или dire) с наибольшей долей побед

select win_side
from (select win_side, count(id) as c
      from matches
      group by win_side
      order by c desc
      limit 1) as wsc

--2.Герой с атрибутом "strength", который был в наибольшем числе игр

select name from
(select name, count(match_id) as c from
(select * from
(select name,
       description,
       hh1.id             as hh_id,
       side,
       match_id,
       hero_id
from (select name, description, heroes.id
      from heroes
               join attributes on heroes.attribute = attributes.id
      where attributes.attribute = 'strength') as hh1
         join player_matches on hh1.id = player_matches.hero_id) as hh2
join matches on match_id = matches.id) as hh3
group by (name)
order by c desc
limit 1) as hh4;

--3.Средняя длительность игр

select avg(duration) from matches;

--4.Вывести количество игр за каждый год

select count(time), extract(year from time) as year from matches
group by time;

--5. Вывести 10 самых дорогих предметов

select name, cost from skins
order by cost desc
limit 10;

--6. Вывести игроков, у которых суммарная стоимость предметов в инвентаре превышает Х

select player_id, sum_cost from
(select player_id, sum(cost) as sum_cost from
(select player_id, cost from
possesions join skins on possesions.skin_id = skins.id) as hh1
group by player_id) as hh2
where sum_cost > 10;

--7. Для каждого игрока вывести героя с наибольшим % побед

select player_id, hero_id, percent as victory_percent
from (select player_id,
             hero_id,
             percent,
             max(percent) over (partition by player_id) as m
      from (select 100.0 * coalesce(c_win, 0)::float / (coalesce(c_win, 0) + coalesce(c_defeat, 0)) as percent,
                   hero_id,
                   player_id
            from (select c_win,
                         c_defeat,
                         coalesce(hh2.hero_id, hh4.hero_id)     as hero_id,
                         coalesce(hh2.player_id, hh4.player_id) as player_id
                  from (select count(*) as c_win, hero_id, player_id
                        from (select hero_id, player_id
                              from matches
                                       join player_matches on matches.id = player_matches.match_id
                              where win_side = side) as hh
                        group by (hero_id, player_id)) as hh2
                           full outer join(select count(*) as c_defeat, hero_id, player_id
                                           from (select hero_id, player_id
                                                 from matches
                                                          join player_matches on matches.id = player_matches.match_id
                                                 where win_side != side) as hh3
                                           group by (hero_id, player_id)) as hh4
                                          on (hh2.player_id = hh4.player_id and hh2.hero_id = hh4.hero_id)) as hh5) as hh6) as hh7
where percent = m
order by player_id;

