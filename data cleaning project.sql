/*
cleaning the data using sql queries
*/
select * from PortfolioProject.dbo.NashvilleHousing

--standardize the date format

select SaleDateConverted,convert(date,SaleDate) from PortfolioProject.dbo.NashvilleHousing

alter table NashvilleHousing Add SaleDateConverted date;

update NashvilleHousing set SaleDateConverted=convert(date,SaleDate)


--populate the property address data


select PropertyAddress from PortfolioProject.dbo.NashvilleHousing where PropertyAddress is null


select * from PortfolioProject.dbo.NashvilleHousing where PropertyAddress is null


select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress ,isnull(a.PropertyAddress,b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousing a 
join PortfolioProject.dbo.NashvilleHousing b
on a.parcelID=b.ParcelID 
and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress=isnull(a.PropertyAddress,b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousing a 
join PortfolioProject.dbo.NashvilleHousing b
on a.parcelID=b.ParcelID 
and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null


--Breaking the 'address' columns into adress,city,state


select PropertyAddress from PortfolioProject.dbo.NashvilleHousing

select substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)) as Address,
CHARINDEX(',',PropertyAddress)                 -- it tells the 'position of comma' (number)

from PortfolioProject.dbo.NashvilleHousing

select substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address
,substring(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress)) as Address --here '+1' is included so that the 'address' should not start with 'comma'

from PortfolioProject.dbo.NashvilleHousing

alter table NashvilleHousing Add PropertySplitAddress nvarchar(255);

update NashvilleHousing set PropertySplitAddress = substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) 

alter table NashvilleHousing Add PropertySplitcity date;

update NashvilleHousing set PropertySplitAddress = substring(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress))

select * from PortfolioProject.dbo.NashvilleHousing   -- see check with this the columns 'PropertySplitcity', 'propertySplitAddress' are created 

select OwnerAddress from PortfolioProject.dbo.NashvilleHousing


select PARSENAME(Replace(OwnerAddress,',','.'),3) 

,PARSENAME(Replace(OwnerAddress,',','.'),2) 

,PARSENAME(Replace(OwnerAddress,',','.'),1) 

from PortfolioProject.dbo.NashvilleHousing


alter table NashvilleHousing Add OwnerSplitAddress nvarchar(255);

update NashvilleHousing set  OwnerSplitAddress = PARSENAME(Replace(OwnerAddress,',','.'),3) 

alter table NashvilleHousing Add  OwnerSplitcity nvarchar(255);

update NashvilleHousing set  OwnerSplitCity = PARSENAME(Replace(OwnerAddress,',','.'),2) 


alter table NashvilleHousing Add  OwnerSplitState nvarchar(255);

update NashvilleHousing set  OwnerSplitState = PARSENAME(Replace(OwnerAddress,',','.'),1) 


select * from PortfolioProject.dbo.NashvilleHousing 


-- changing Y and N to Yes and No in " sold as Vacant" field

select distinct(SoldAsVacant),count(SoldAsVacant) from PortfolioProject.dbo.NashvilleHousing group by SoldAsVacant order by SoldAsVacant

select SoldAsVacant
,case when SoldAsVacant='Y' then 'Yes'
      when SoldAsVacant='N' then 'No'
      else SoldAsVacant
	  end
from PortfolioProject.dbo.NashvilleHousing 

update NashvilleHousing
set SoldAsVacant=case when SoldAsVacant='Y' then 'Yes'
      when SoldAsVacant='N' then 'No'
      else SoldAsVacant
	  end
from PortfolioProject.dbo.NashvilleHousing 


--removing the duplicates

with RowNumCTE as(
select *,
ROW_NUMBER() over (
partition by ParcelID,
             PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 order by 
			 UniqueID)row_num

from PortfolioProject.dbo.NashvilleHousing 

--order by ParcelID 
)
select *  from RowNumCTE   # after using delete in place of 'select' at the end of the block of query the duplicates are gone
where row_num>1


-- deleting the unused columns

alter table PortfolioProject.dbo.NashvilleHousing
drop column OwnerAddress,TaxDistrict,PropertyAddress

select * from PortfolioProject.dbo.NashvilleHousing

alter table PortfolioProject.dbo.NashvilleHousing
drop column SaleDate











