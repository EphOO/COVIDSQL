SELECT *
FROM Covid19Death

SELECT *
FROM Covid19Vaccine

--% of total cases vs Total deaths in Nigeeria 

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM Covid19Death
WHERE location = 'Nigeria'
ORDER BY DeathPercentage DESC

--total cases vs population in Nigeria

SELECT location, date,  population, total_cases, (total_cases/ population)*100 AS Death_Popu_Percentage
FROM Covid19Death
WHERE location = 'Nigeria'
ORDER BY Death_Popu_Percentage DESC

--Countries in Africa with highest covid infection compared to population

SELECT location, population, MAX(total_cases)AS infection_Count, MAX(total_cases/population) AS Population_Infected_Percentage
FROM Covid19Death
WHERE continent = 'Africa'
GROUP BY location, population
ORDER BY Population_Infected_Percentage DESC

--Countries in Africa with highest death count per population
SELECT location, MAX(total_cases)AS DeathsCount
FROM Covid19Death
WHERE continent = 'Africa'
GROUP BY location
ORDER BY DeathsCount DESC

--Africa ranking in death count per population

SELECT continent, MAX(total_cases)AS ContinentRanking
FROM Covid19Death
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY ContinentRanking DESC

--World daily record on death percentage

SELECT date, SUM(new_cases) AS total_cases, SUM(cast(new_deaths as int)) AS total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS PercentageDeath 
FROM Covid19Death
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2

--World daily record on total cases vs total deaths in percentage

SELECT SUM(new_cases) AS total_cases, SUM(cast(new_deaths as int)) AS total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS PercentageDeath 
FROM Covid19Death
WHERE continent IS NOT NULL
ORDER BY 1,2

--Joining the Covid19Death and Covid19Vaccination tables

SELECT *
FROM Covid19Death a
JOIN Covid19Vaccine b
    ON a.location = b.location
	AND a.date = b.date

--total population and vaccination for continent and countries

SELECT a.continent, a.location, a.date, a.population, b.new_vaccinations
FROM Covid19Death a
JOIN Covid19Vaccine b
    ON a.location = b.location
	AND a.date = b.date
WHERE a.continent IS NOT NULL
ORDER BY 1,2,3