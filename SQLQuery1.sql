--Find the count of total rows in Vaccination table.
select count(*) from PortofolioSQL.dbo.CovidVaccinations
--- Result 85171 (matches the rows in excel sheet)

-- Select all row values & sort by country & date
select * from PortofolioSQL.dbo.CovidVaccinations
 order by 3,4


select Continent, location   from PortofolioSQL.dbo.CovidVaccinations
 order by 3,4

 ----2- Second table
 --Find the count of total rows in Death table.
 select count(*) from PortofolioSQL.dbo.CovidDeaths
--- Result 85171 (matches the rows in excel sheet)

 -- All row values with total deaths.
select * from PortofolioSQL.dbo.Coviddeaths
where continent is not null
 order by 3,4


--- Select Only specific columns ordered by Continent, Location & than date.
 select continent, location, date, new_cases, total_cases, new_deaths, total_deaths, population 
 from PortofolioSQL.dbo.CovidDeaths
 where continent is not null
 order by 2,3,4

 --- Calculate percentage of total deaths Vs Total_cases
 --- Shows the likelyhood of dying if you contract Covid in US.
 select continent, location, date, new_cases, total_cases, new_deaths, total_deaths, population,
 (total_deaths/Total_cases)*100 as DeathPercentage
 from PortofolioSQL.dbo.CovidDeaths
 where location = 'United States'
  order by 2,3,4

  --- Calculate percentage of total deaths Vs Total_cases
 --- Shows the likelyhood of dying if you contract Covid in India.
 select continent, location, date, new_cases, total_cases, new_deaths, total_deaths, population,
 (total_deaths/Total_cases)*100 as DeathPercentage
 from PortofolioSQL.dbo.CovidDeaths
 where location = 'India'
 order by 2,3,4

 --- Calculate percentage of total cases Vs population (US) - %age of population got covid
 -- Likely to get infected ith covid in US (Max 10%)
 select continent, location, date, total_cases, population,
 (Total_cases/population)*100 as TotalcasesPercentage
 from PortofolioSQL.dbo.CovidDeaths
 where location = 'United States'
 order by 2,3,4

  --- Calculate percentage of total cases Vs population (India) - %age of population got covid
 -- Likely to get infected ith covid in India (Max 1.3% only)
 select continent, location, date, total_cases, population,
 (Total_cases/population)*100 as TotalcasesPercentage
 from PortofolioSQL.dbo.CovidDeaths
 where location = 'India'
 order by 2,3,4

 --- Which contry has highest Infection rate compared to population
  select location, max(total_cases) as MaxTotalCases, population,
 (max(Total_cases/population))*100 as TotalcasesPercentage
 from PortofolioSQL.dbo.CovidDeaths
 where continent is not null
 Group by Location, Population
  order by TotalcasesPercentage DESC


  
 --- Which contry has highest Death rate compared to population 
 -- also checking only if Continent is not null
 -- we can order by TotalDeathPercentage or Total_Deaths
  select location, max(total_deaths) as MaxTotalDeaths, population,
 (max(total_deaths/population))*100 as TotalDeathsPercentage
 from PortofolioSQL.dbo.CovidDeaths
 where continent is not null
 Group by Location, Population
 order by MaxTotalDeaths DESC
--  order by TotalDeathsPercentage DESC


--- Which countinent has highest Death count (Got only 6 continents when selected Continent, did not get Europe)
 -- also checking only if Continent is not null
 -- we can order by Total_Deaths
  select continent, MAX(total_deaths) as MaxTotalDeaths
  from PortofolioSQL.dbo.CovidDeaths
  where continent is not null
 Group by continent
 order by MaxTotalDeaths DESC
--  order by TotalDeathsPercentage DESC


--- Which countinent has highest Death count (Got more when selecting Location)
 -- also checking only if Continent is not null  -- we can order by Total_Deaths
  select location, MAX(total_deaths) as MaxTotalDeaths
  from PortofolioSQL.dbo.CovidDeaths
  where continent is null
  --where continent is not null (will also get countriees)
 Group by location
 order by MaxTotalDeaths DESC



 -- Joining 2 Tables, to get all columns from both tables
 select * from PortofolioSQL.dbo.CovidVaccinations V
 JOIN PortofolioSQL.dbo.CovidDeaths D
 on V.Location = D.location
 and V.date = D.date

 ----- Total Population Vs Vacinations
 select D.continent, D.Location, D.Population, V.people_vaccinated 
 from PortofolioSQL.dbo.CovidVaccinations V
 JOIN PortofolioSQL.dbo.CovidDeaths D
 on V.Location = D.location
 and V.date = D.date
 where D.continent is not null 
 Order by 1,2,3


 Join 2 tables & create a temporary view

 Create view new_covidDeathswithlonglat as 
 Select D.iso_code, D.continent, D.total_cases, D.total_deaths, C.Latitude_average, C.Longitude_average 
 from PortofolioSQL.dbo.Coviddeaths D, PortofolioSQL.dbo.countrycodesandlongitudes C
 where D.iso_code = C.Country_code
 

 Select * from new_covidDeathswithlonglat
 
 Select count(*) from new_covidDeathswithlonglat

 Drop view new_covidDeathswithlonglat
