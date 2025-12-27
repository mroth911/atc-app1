BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[AppRoles] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK__AppRoles__3214EC074A1F8543] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [UQ__AppRoles__737584F600C58CE5] UNIQUE NONCLUSTERED ([Name])
);

-- CreateTable
CREATE TABLE [dbo].[AppUserRoles] (
    [UserId] INT NOT NULL,
    [RoleId] INT NOT NULL,
    CONSTRAINT [PK__AppUserR__AF2760ADABAC9637] PRIMARY KEY CLUSTERED ([UserId],[RoleId])
);

-- CreateTable
CREATE TABLE [dbo].[AppUsers] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Email] NVARCHAR(256) NOT NULL,
    [DisplayName] NVARCHAR(200) NOT NULL,
    [PasswordHash] NVARCHAR(200) NOT NULL,
    [IsActive] BIT NOT NULL CONSTRAINT [DF__AppUsers__IsActi__4F12BBB9] DEFAULT 1,
    [CreatedAt] DATETIME2 NOT NULL CONSTRAINT [DF__AppUsers__Create__5006DFF2] DEFAULT sysutcdatetime(),
    CONSTRAINT [PK__AppUsers__3214EC07A3CC279C] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [UQ__AppUsers__A9D105346187CE45] UNIQUE NONCLUSTERED ([Email])
);

-- CreateTable
CREATE TABLE [dbo].[Caregivers] (
    [Caregiver] NCHAR(10)
);

-- CreateTable
CREATE TABLE [dbo].[CaseMng] (
    [CaseMngID] INT NOT NULL IDENTITY(1,1),
    [CaseMngPhone] NVARCHAR(50),
    [CaseMngExtension] NVARCHAR(5),
    [CaseMngFirstName] NVARCHAR(23),
    [CaseMngLastName] NVARCHAR(23),
    [CaseMngNote] NVARCHAR(100),
    CONSTRAINT [CaseMng$PrimaryKey] PRIMARY KEY CLUSTERED ([CaseMngID])
);

-- CreateTable
CREATE TABLE [dbo].[CheckDetail] (
    [CheckDetailID] INT NOT NULL IDENTITY(1,1),
    [CheckID] INT NOT NULL CONSTRAINT [DF__CheckDeta__Check__41EDCAC5] DEFAULT 0,
    [CheckDetailDate] DATETIME2,
    [DocNumber] NVARCHAR(20),
    [AccountNumber] NVARCHAR(20),
    [CheckDetAmount] REAL CONSTRAINT [DF__CheckDeta__Check__42E1EEFE] DEFAULT 0,
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [CheckDetail$PrimaryKey] PRIMARY KEY CLUSTERED ([CheckDetailID])
);

-- CreateTable
CREATE TABLE [dbo].[CheckTitle] (
    [CheckId] INT NOT NULL IDENTITY(1,1),
    [CheckDate] DATETIME2,
    [DocumentNumber] NVARCHAR(30),
    [CheckFrom] NVARCHAR(20),
    [CheckAmount] REAL CONSTRAINT [DF__CheckTitl__Check__43D61337] DEFAULT 0,
    [DetailAmountTotal] REAL CONSTRAINT [DF__CheckTitl__Detai__44CA3770] DEFAULT 0,
    [Notes] NVARCHAR(50),
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [CheckTitle$PrimaryKey] PRIMARY KEY CLUSTERED ([CheckId])
);

-- CreateTable
CREATE TABLE [dbo].[Client] (
    [SSN] NVARCHAR(9) NOT NULL,
    [FirstName] NVARCHAR(30),
    [LastName] NVARCHAR(30),
    [Home] NVARCHAR(10),
    [Street] NVARCHAR(30),
    [Apt] NVARCHAR(20),
    [Town] NVARCHAR(15),
    [State] NVARCHAR(2) CONSTRAINT [DF__Client__State__45BE5BA9] DEFAULT 'CT',
    [Zip] NVARCHAR(15),
    [Phone] NVARCHAR(30),
    [DOB] DATETIME2,
    [Gender] NVARCHAR(1),
    CONSTRAINT [Client$PrimaryKey] PRIMARY KEY CLUSTERED ([SSN])
);

-- CreateTable
CREATE TABLE [dbo].[Client2] (
    [SSN] NVARCHAR(9) NOT NULL,
    [Note] NVARCHAR(60),
    [CCCINum] NVARCHAR(10),
    [Medicaid] NVARCHAR(10),
    [FundNum] NVARCHAR(3),
    [CaseManagerID] INT CONSTRAINT [DF__Client2__CaseMan__46B27FE2] DEFAULT 0,
    [Diagnos] NVARCHAR(255),
    [EffDate] DATETIME2,
    [ExpDate] DATETIME2,
    [HoursNotes] NVARCHAR(50),
    [ADCDays] REAL CONSTRAINT [DF__Client2__ADCDays__47A6A41B] DEFAULT 0,
    [ADCNotes] NVARCHAR(25),
    [MOWNotes] NVARCHAR(50),
    [DSS] INT CONSTRAINT [DF__Client2__DSS__489AC854] DEFAULT 0,
    [OfficeNumber] NVARCHAR(10),
    [EmergencyName] NVARCHAR(50),
    [EmergencyPnone] NVARCHAR(50),
    [Status] NVARCHAR(10),
    [BillingPayer] NVARCHAR(50),
    [BillingAddress1] NVARCHAR(50),
    [BillingAddress2] NVARCHAR(50),
    [BillingCity] NVARCHAR(50),
    [BillingZIP] NVARCHAR(20),
    [BillingState] NVARCHAR(2),
    [BillingNote] NVARCHAR(200),
    [SSN0] NVARCHAR(9),
    [DiagCode] NVARCHAR(10),
    [ClientCategory] NVARCHAR(5),
    [ICD9] NVARCHAR(20),
    [ICD10] NVARCHAR(20),
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [Client2$PrimaryKey] PRIMARY KEY CLUSTERED ([SSN])
);

-- CreateTable
CREATE TABLE [dbo].[ClientAssignedHour] (
    [RecID] INT NOT NULL IDENTITY(1,1),
    [SSN] NVARCHAR(9),
    [EffDate] DATETIME2,
    [ExpDate] DATETIME2,
    [HMWeek] REAL CONSTRAINT [DF__ClientAss__HMWee__498EEC8D] DEFAULT 0,
    [CPWeek] REAL CONSTRAINT [DF__ClientAss__CPWee__4A8310C6] DEFAULT 0,
    [ApptWeek] REAL CONSTRAINT [DF__ClientAss__ApptW__4B7734FF] DEFAULT 0,
    [CHWeek] REAL CONSTRAINT [DF__ClientAss__CHWee__4C6B5938] DEFAULT 0,
    [LIWeek] REAL CONSTRAINT [DF__ClientAss__LIWee__4D5F7D71] DEFAULT 0,
    [ADCWeek] REAL CONSTRAINT [DF__ClientAss__ADCWe__4E53A1AA] DEFAULT 0,
    [PCAWeek] REAL CONSTRAINT [DF__ClientAss__PCAWe__4F47C5E3] DEFAULT 0,
    [PCA12Week] REAL CONSTRAINT [DF__ClientAss__PCA12__503BEA1C] DEFAULT 0,
    [PCA24Week] REAL CONSTRAINT [DF__ClientAss__PCA24__51300E55] DEFAULT 0,
    [PCA24SubWeek] REAL CONSTRAINT [DF__ClientAss__PCA24__5224328E] DEFAULT 0,
    [PCASubWeek] REAL CONSTRAINT [DF__ClientAss__PCASu__531856C7] DEFAULT 0,
    [HMBiWeek] REAL CONSTRAINT [DF__ClientAss__HMBiW__540C7B00] DEFAULT 0,
    [CPBiWeek] REAL CONSTRAINT [DF__ClientAss__CPBiW__55009F39] DEFAULT 0,
    [HMMonth] REAL CONSTRAINT [DF__ClientAss__HMMon__55F4C372] DEFAULT 0,
    [CPMonth] REAL CONSTRAINT [DF__ClientAss__CPMon__56E8E7AB] DEFAULT 0,
    [MedMonth] REAL CONSTRAINT [DF__ClientAss__MedMo__57DD0BE4] DEFAULT 0,
    [CHMonth] REAL CONSTRAINT [DF__ClientAss__CHMon__58D1301D] DEFAULT 0,
    [ADCMonth] REAL CONSTRAINT [DF__ClientAss__ADCMo__59C55456] DEFAULT 0,
    [PCAMonth] REAL CONSTRAINT [DF__ClientAss__PCAMo__5AB9788F] DEFAULT 0,
    [PCA12Month] REAL CONSTRAINT [DF__ClientAss__PCA12__5BAD9CC8] DEFAULT 0,
    [PCA24Month] REAL CONSTRAINT [DF__ClientAss__PCA24__5CA1C101] DEFAULT 0,
    [PCA24SubMonth] REAL CONSTRAINT [DF__ClientAss__PCA24__5D95E53A] DEFAULT 0,
    [PCABiWeek] REAL CONSTRAINT [DF__ClientAss__PCABi__5E8A0973] DEFAULT 0,
    [FCA1Week] REAL CONSTRAINT [DF__ClientAss__FCA1W__5F7E2DAC] DEFAULT 0,
    [FCA2Week] REAL CONSTRAINT [DF__ClientAss__FCA2W__607251E5] DEFAULT 0,
    [FCA3Week] REAL CONSTRAINT [DF__ClientAss__FCA3W__6166761E] DEFAULT 0,
    [FCA4Week] REAL CONSTRAINT [DF__ClientAss__FCA4W__625A9A57] DEFAULT 0,
    [FCAVNWeek] REAL CONSTRAINT [DF__ClientAss__FCAVN__634EBE90] DEFAULT 0,
    [PCARspWeek] REAL CONSTRAINT [DF__ClientAss__PCARs__6442E2C9] DEFAULT 0,
    [PCA12RspWeek] REAL CONSTRAINT [DF__ClientAss__PCA12__65370702] DEFAULT 0,
    [PCA24RspWeek] REAL CONSTRAINT [DF__ClientAss__PCA24__662B2B3B] DEFAULT 0,
    [HMRspWeek] REAL CONSTRAINT [DF__ClientAss__HMRsp__671F4F74] DEFAULT 0,
    [CPRspWeek] REAL CONSTRAINT [DF__ClientAss__CPRsp__681373AD] DEFAULT 0,
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [ClientAssignedHour$PrimaryKey] PRIMARY KEY CLUSTERED ([RecID])
);

-- CreateTable
CREATE TABLE [dbo].[ClientAssignedHourExtra] (
    [RecID] INT NOT NULL IDENTITY(1,1),
    [SSN] NVARCHAR(9),
    [Year] INT CONSTRAINT [DF__ClientAssi__Year__690797E6] DEFAULT 0,
    [MonthID] INT CONSTRAINT [DF__ClientAss__Month__69FBBC1F] DEFAULT 0,
    [HM] REAL CONSTRAINT [DF__ClientAssign__HM__6AEFE058] DEFAULT 0,
    [CP] REAL CONSTRAINT [DF__ClientAssign__CP__6BE40491] DEFAULT 0,
    [CH] REAL CONSTRAINT [DF__ClientAssign__CH__6CD828CA] DEFAULT 0,
    [ADC] REAL CONSTRAINT [DF__ClientAssig__ADC__6DCC4D03] DEFAULT 0,
    [PCA] REAL CONSTRAINT [DF__ClientAssig__PCA__6EC0713C] DEFAULT 0,
    [PCA12] REAL CONSTRAINT [DF__ClientAss__PCA12__6FB49575] DEFAULT 0,
    [PCA24] REAL CONSTRAINT [DF__ClientAss__PCA24__70A8B9AE] DEFAULT 0,
    [PCA24Sub] REAL CONSTRAINT [DF__ClientAss__PCA24__719CDDE7] DEFAULT 0,
    [PCARsp] REAL CONSTRAINT [DF__ClientAss__PCARs__72910220] DEFAULT 0,
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [ClientAssignedHourExtra$PrimaryKey] PRIMARY KEY CLUSTERED ([RecID])
);

-- CreateTable
CREATE TABLE [dbo].[ClientMedStatus] (
    [RecID] INT NOT NULL IDENTITY(1,1),
    [SSN] NVARCHAR(9),
    [EffDate] DATETIME2,
    [Living_Arrangments] NVARCHAR(100),
    [Assisted_Appliance] NVARCHAR(100),
    [Function_Limitation] NVARCHAR(100),
    [Behavior_Issues] NVARCHAR(100),
    [Mental_Status] NVARCHAR(100),
    [Diet] NVARCHAR(100),
    [Allergies] NVARCHAR(100),
    [Telephone] NVARCHAR(20),
    [Transportation_Ability_To_Travel] NVARCHAR(20),
    [Full_Meal_Preparation] NVARCHAR(20),
    [Light_Meal_Preparation] NVARCHAR(20),
    [Laundry] NVARCHAR(20),
    [Legal_Financial] NVARCHAR(20),
    [Light_Housekeepng] NVARCHAR(20),
    [Heavy_Chores] NVARCHAR(20),
    [Medication] NVARCHAR(20),
    [Shopping] NVARCHAR(20),
    [Toileting] NVARCHAR(100),
    [Ambulation] NVARCHAR(70),
    [Grooming] NVARCHAR(50),
    [Eating] NVARCHAR(50),
    [Transfering] NVARCHAR(50),
    [Bathing] NVARCHAR(50),
    [Dressing] NVARCHAR(50),
    [Visit] NVARCHAR(20),
    [Ligally_Liable] NVARCHAR(10),
    [Understands_Documantation] NVARCHAR(10),
    [Able_To_Perform_Duties] NVARCHAR(10),
    [Caregiver_Report_Complete] NVARCHAR(10),
    [Access_To_Emergency_Numbers] NVARCHAR(10),
    [Access_ToAgency_24_Hours] NVARCHAR(10),
    [Training_Completed] NVARCHAR(10),
    [Training_Provided_On] DATETIME2,
    [Confidentiality_Integrity_Behaviors] NVARCHAR(55),
    [Lifting_and_Positioning_Techniques] NVARCHAR(5),
    [Medical_Asepsis_And_Handwasing] NVARCHAR(5),
    [Infection_Control] NVARCHAR(5),
    [Bathing _And_Perineal_Care] NVARCHAR(5),
    [Bedpans] NVARCHAR(5),
    [Emergency_Response] NVARCHAR(5),
    [Hearing_Aid_And_Denture_Care] NVARCHAR(5),
    [Serving_Meals_And_Preparation] NVARCHAR(5),
    [Role_Of_PCA_And_HHA] NVARCHAR(5),
    [Reporting_EmerncyAND_Elopements] NVARCHAR(5),
    [Kitchen_Safety_And_Food_Storage] NVARCHAR(5),
    CONSTRAINT [ClientMedStatus$PrimaryKey] PRIMARY KEY CLUSTERED ([RecID])
);

-- CreateTable
CREATE TABLE [dbo].[ClientNarrativeSupervision] (
    [RecId] INT NOT NULL IDENTITY(1,1),
    [SSN] NVARCHAR(9),
    [EmployeeID] INT,
    [EffDate] DATETIME2,
    [Desc] NVARCHAR(255),
    CONSTRAINT [ClientNarrativeSupervision$PrimaryKey] PRIMARY KEY CLUSTERED ([RecId])
);

-- CreateTable
CREATE TABLE [dbo].[ClientProviderReport] (
    [RecID] INT NOT NULL IDENTITY(1,1),
    [SSN] NVARCHAR(9),
    [EffDate] DATETIME2,
    [ExpDate] DATETIME2,
    [VisitsMonth] INT CONSTRAINT [DF__ClientPro__Visit__73852659] DEFAULT 0,
    [EmployeeCompanion] NVARCHAR(50),
    [Companionship] BIT CONSTRAINT [DF__ClientPro__Compa__74794A92] DEFAULT 0,
    [Errands] BIT CONSTRAINT [DF__ClientPro__Erran__756D6ECB] DEFAULT 0,
    [Appointment] BIT CONSTRAINT [DF__ClientPro__Appoi__76619304] DEFAULT 0,
    [Cleaning] BIT CONSTRAINT [DF__ClientPro__Clean__7755B73D] DEFAULT 0,
    [Laundry] BIT CONSTRAINT [DF__ClientPro__Laund__7849DB76] DEFAULT 0,
    [Housekeeping] BIT CONSTRAINT [DF__ClientPro__House__793DFFAF] DEFAULT 0,
    [Meal] BIT CONSTRAINT [DF__ClientProv__Meal__7A3223E8] DEFAULT 0,
    [MedicalReminder] BIT CONSTRAINT [DF__ClientPro__Medic__7B264821] DEFAULT 0,
    [Transportation] BIT CONSTRAINT [DF__ClientPro__Trans__7C1A6C5A] DEFAULT 0,
    [Yard] BIT CONSTRAINT [DF__ClientProv__Yard__7D0E9093] DEFAULT 0,
    [Bathing] BIT CONSTRAINT [DF__ClientPro__Bathi__7E02B4CC] DEFAULT 0,
    [Dressing] BIT CONSTRAINT [DF__ClientPro__Dress__7EF6D905] DEFAULT 0,
    [Feeding] BIT CONSTRAINT [DF__ClientPro__Feedi__7FEAFD3E] DEFAULT 0,
    [Walking] BIT CONSTRAINT [DF__ClientPro__Walki__00DF2177] DEFAULT 0,
    [Toileting] BIT CONSTRAINT [DF__ClientPro__Toile__01D345B0] DEFAULT 0,
    [Transfering] BIT CONSTRAINT [DF__ClientPro__Trans__02C769E9] DEFAULT 0,
    [Mail] BIT CONSTRAINT [DF__ClientProv__Mail__03BB8E22] DEFAULT 0,
    [Telephone] BIT CONSTRAINT [DF__ClientPro__Telep__04AFB25B] DEFAULT 0,
    [Grooming] BIT CONSTRAINT [DF__ClientPro__Groom__05A3D694] DEFAULT 0,
    [SafetyChair] BIT CONSTRAINT [DF__ClientPro__Safet__0697FACD] DEFAULT 0,
    [Chores] BIT CONSTRAINT [DF__ClientPro__Chore__078C1F06] DEFAULT 0,
    [TakeOutside] BIT CONSTRAINT [DF__ClientPro__TakeO__0880433F] DEFAULT 0,
    [Other] NVARCHAR(50),
    [Behavior] BIT CONSTRAINT [DF__ClientPro__Behav__09746778] DEFAULT 0,
    [Health] BIT CONSTRAINT [DF__ClientPro__Healt__0A688BB1] DEFAULT 0,
    [Functional] BIT CONSTRAINT [DF__ClientPro__Funct__0B5CAFEA] DEFAULT 0,
    [CareServiceNeeds] BIT CONSTRAINT [DF__ClientPro__CareS__0C50D423] DEFAULT 0,
    [Environment] BIT CONSTRAINT [DF__ClientPro__Envir__0D44F85C] DEFAULT 0,
    [ClientSatisfaction] BIT CONSTRAINT [DF__ClientPro__Clien__0E391C95] DEFAULT 0,
    [Note] NVARCHAR(50),
    [ServiceId] SMALLINT CONSTRAINT [DF__ClientPro__Servi__0F2D40CE] DEFAULT 10,
    [Shopping] BIT CONSTRAINT [DF__ClientPro__Shopp__10216507] DEFAULT 0,
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [ClientProviderReport$PrimaryKey] PRIMARY KEY CLUSTERED ([RecID])
);

-- CreateTable
CREATE TABLE [dbo].[ClientService] (
    [SSN] NVARCHAR(9),
    [EmployeeID] INT CONSTRAINT [DF__ClientSer__Emplo__11158940] DEFAULT 0,
    [ServiceID] INT,
    [DayID] INT,
    [Time] REAL,
    [StartTime] DATETIME2,
    [EffDate] DATETIME2,
    [ExpDate] DATETIME2,
    [WeekMod] NVARCHAR(10),
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[ClientServiceHistory] (
    [SSN] NVARCHAR(9),
    [EmployeeID] INT CONSTRAINT [DF__ClientSer__Emplo__1209AD79] DEFAULT 0,
    [ServiceID] INT,
    [DayID] INT,
    [Time] REAL,
    [StartTime] DATETIME2,
    [EffDate] DATETIME2,
    [ExpDate] DATETIME2,
    [WeekMod] NVARCHAR(10),
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[ClientServiceM] (
    [SSN] NVARCHAR(9),
    [EmployeeID] INT CONSTRAINT [DF__ClientSer__Emplo__12FDD1B2] DEFAULT 0,
    [ServiceID] INT,
    [DayID] INT,
    [Time] REAL,
    [StartTime] DATETIME2,
    [EffDate] DATETIME2,
    [ExpDate] DATETIME2,
    [Period] INT CONSTRAINT [DF__ClientSer__Perio__13F1F5EB] DEFAULT 0,
    [NextService] DATETIME2,
    [LastService] DATETIME2,
    [Notes] NVARCHAR(50),
    [ServiceTypeCd] NVARCHAR(2) CONSTRAINT [DF__ClientSer__Servi__14E61A24] DEFAULT 'M',
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[ClientServiceMDone] (
    [RecID] INT NOT NULL IDENTITY(1,1),
    [SSN] NVARCHAR(9),
    [ServiceDate] DATETIME2,
    [ServiceIDGroup] INT,
    [EmployeeID] INT,
    [Time] FLOAT(53),
    [ServiceTypeCd] NVARCHAR(2),
    [Notes] NVARCHAR(50),
    [Period] INT CONSTRAINT [DF__ClientSer__Perio__15DA3E5D] DEFAULT 0,
    [Schedule] NVARCHAR(255),
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [ClientServiceMDone$PrimaryKey] PRIMARY KEY CLUSTERED ([RecID])
);

-- CreateTable
CREATE TABLE [dbo].[ClientServiceOrder] (
    [RecID] INT NOT NULL IDENTITY(1,1),
    [SSN] NVARCHAR(9),
    [EffDate] DATETIME2,
    [ExpDate] DATETIME2,
    [ServiceId] NVARCHAR(10),
    [Note] NVARCHAR(255),
    [HoursUnits] REAL,
    [Days] REAL,
    [Freq] NVARCHAR(20),
    [Status] NVARCHAR(10),
    [VendorCode] NVARCHAR(10),
    [BatchDate] DATETIME2,
    [CancelDate] DATETIME2,
    [PhoneDate] DATETIME2,
    [SONumber] NVARCHAR(50),
    [SOTypeNVC] NVARCHAR(1),
    [SOModifier] NVARCHAR(10),
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[EDI_837P_ISA] (
    [RecID] INT NOT NULL IDENTITY(1,1),
    [SegID] NVARCHAR(3),
    [ElementID] NVARCHAR(2),
    [ElementValue] NVARCHAR(70),
    [ElementLength] SMALLINT CONSTRAINT [DF__EDI_837P___Eleme__16CE6296] DEFAULT 0,
    [ElementFormat] NVARCHAR(10),
    CONSTRAINT [EDI_837P_ISA$PrimaryKey] PRIMARY KEY CLUSTERED ([RecID])
);

-- CreateTable
CREATE TABLE [dbo].[EDI_837P_SegmentValue] (
    [RecID] INT NOT NULL IDENTITY(1,1),
    [LoopID] NVARCHAR(10),
    [SegID] NVARCHAR(3),
    [ElementID] NVARCHAR(2),
    [ElementValue] NVARCHAR(70),
    CONSTRAINT [EDI_837P_SegmentValue$PrimaryKey] PRIMARY KEY CLUSTERED ([RecID])
);

-- CreateTable
CREATE TABLE [dbo].[EDI_Batch] (
    [BatchNum] INT CONSTRAINT [DF__EDI_Batch__Batch__17C286CF] DEFAULT 0
);

-- CreateTable
CREATE TABLE [dbo].[EDI_Processor] (
    [RecNo] INT NOT NULL IDENTITY(1,1),
    [ProcessorID] NVARCHAR(2),
    [ProcessorType] NVARCHAR(20),
    [PROCESSOR_NAME] NVARCHAR(35),
    [PROCESSOR_ETIN] NVARCHAR(15),
    [PROCESSOR_ID_QUALIFIER] NVARCHAR(2),
    [PROCESSOR_ID_CODE] NVARCHAR(35),
    [ContactName] NVARCHAR(50),
    [ContactPhone] NVARCHAR(20),
    [ContactFax] NVARCHAR(20),
    [ContactEmail] NVARCHAR(50),
    CONSTRAINT [EDI_Processor$PrimaryKey] PRIMARY KEY CLUSTERED ([RecNo]),
    CONSTRAINT [EDI_Processor$PROCESSOR_SAK] UNIQUE NONCLUSTERED ([ProcessorID])
);

-- CreateTable
CREATE TABLE [dbo].[EDI_Provider] (
    [RecNo] INT NOT NULL IDENTITY(1,1),
    [Prov_Code] NVARCHAR(2),
    [Prov_Type] NVARCHAR(25),
    [LNAME] NVARCHAR(35),
    [TAX_ID] NVARCHAR(12),
    [UPIN_USIN] NVARCHAR(6),
    [MEDICAD_NO] NVARCHAR(15),
    [PROV_NUM_1] NVARCHAR(15),
    [PROV_NUM_2] NVARCHAR(15),
    [SPECIALTY] NVARCHAR(3),
    [SPE_LIC_NO] NVARCHAR(15),
    [ST_LIC_NO] NVARCHAR(15),
    [TAXONOMY_CD] NVARCHAR(10),
    [PROV_ID_QUALIFIER] NVARCHAR(2),
    [PROV_FNAME] NVARCHAR(25),
    [PROV_TYPE_QUALIFIER] NVARCHAR(1),
    [ADDR_LINE1] NVARCHAR(55),
    [ADDR_LINE2] NVARCHAR(55),
    [ADDR_CITY] NVARCHAR(30),
    [ADDR_STATE] NVARCHAR(2),
    [ADDR_ZIP] NVARCHAR(10),
    [TAXID_SSN_QUALIFIER] NVARCHAR(2),
    [NPI] NVARCHAR(10),
    [AVRS] NVARCHAR(9),
    CONSTRAINT [EDI_Provider$PrimaryKey] PRIMARY KEY CLUSTERED ([RecNo]),
    CONSTRAINT [EDI_Provider$medicad_no] UNIQUE NONCLUSTERED ([MEDICAD_NO],[TAXONOMY_CD],[ADDR_ZIP])
);

-- CreateTable
CREATE TABLE [dbo].[EmplMileage] (
    [EmployeeID] INT CONSTRAINT [DF__EmplMilea__Emplo__18B6AB08] DEFAULT 0,
    [EffDate] DATETIME2,
    [ExpDate] DATETIME2,
    [Price] FLOAT(53) CONSTRAINT [DF__EmplMilea__Price__19AACF41] DEFAULT 0,
    [Note] NVARCHAR(255),
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[EmplNarrative] (
    [RecId] INT NOT NULL IDENTITY(1,1),
    [EmployeeID] INT CONSTRAINT [DF__EmplNarra__Emplo__1A9EF37A] DEFAULT 0,
    [Description] NVARCHAR(255),
    [EffDate] DATETIME2,
    CONSTRAINT [EmplNarrative$PrimaryKey] PRIMARY KEY CLUSTERED ([RecId])
);

-- CreateTable
CREATE TABLE [dbo].[Employee] (
    [EmployeeID] INT NOT NULL IDENTITY(1,1),
    [SSN] NVARCHAR(9),
    [First Name] NVARCHAR(30),
    [Mid Initial] NVARCHAR(1),
    [Last Name] NVARCHAR(30),
    [Gender] NVARCHAR(1),
    [DOB] DATETIME2,
    [Home] NVARCHAR(10),
    [Street] NVARCHAR(30),
    [Apt] NVARCHAR(10),
    [Town] NVARCHAR(15),
    [State] NVARCHAR(2) CONSTRAINT [DF__Employee__State__1B9317B3] DEFAULT 'CT',
    [Zip Code] NVARCHAR(15),
    [HomePhone] NVARCHAR(10),
    [WorkPhone] NVARCHAR(10),
    [Cell] NVARCHAR(10),
    [E-mail] NVARCHAR(30),
    [Reference] NVARCHAR(30),
    [Rate1] REAL,
    [Rate2] REAL,
    [Rate3] REAL,
    [Rate4] REAL CONSTRAINT [DF__Employee__Rate4__1C873BEC] DEFAULT 0,
    [Hours4] REAL CONSTRAINT [DF__Employee__Hours4__1D7B6025] DEFAULT 0,
    [DateHire] DATETIME2,
    [DateLast] DATETIME2,
    [Position] NVARCHAR(50),
    [EmrgContactName] NVARCHAR(50),
    [EmrgContactPhone] NVARCHAR(50),
    [PrimaryLanguageID] INT CONSTRAINT [DF__Employee__Primar__1E6F845E] DEFAULT 0,
    [SecondaryLanguageID] INT CONSTRAINT [DF__Employee__Second__1F63A897] DEFAULT 0,
    [Status] NVARCHAR(15),
    [MarritalStatus] NVARCHAR(25),
    [FamilyStatus] NVARCHAR(50),
    [FullTime] NVARCHAR(50),
    [Note] NVARCHAR(100),
    [EmpAuthorizationEndDate] DATETIME2,
    [DriverLicenseEndDate] DATETIME2,
    [Dept] NVARCHAR(10),
    [Hours] REAL CONSTRAINT [DF__Employee__Hours__2057CCD0] DEFAULT 0,
    [ValidDocType] NVARCHAR(20),
    [ValidDocEndDate] DATETIME2,
    [PositionEVV] NVARCHAR(6),
    [CarRegistrationEndDate] DATETIME2,
    [CarInsuranceEndDate] DATETIME2,
    [EmployeeID_FK] INT,
    [ResignationReason] NVARCHAR(10),
    [PayrollNote] NVARCHAR(100),
    [EvaluationDt] DATETIME2,
    [Vax] NVARCHAR(3),
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [Employee$PrimaryKey] PRIMARY KEY CLUSTERED ([EmployeeID]),
    CONSTRAINT [Employee$SS #] UNIQUE NONCLUSTERED ([SSN])
);

-- CreateTable
CREATE TABLE [dbo].[Employees] (
    [Employees] NCHAR(10)
);

-- CreateTable
CREATE TABLE [dbo].[EmplRateOverride] (
    [EmployeeID] INT CONSTRAINT [DF__EmplRateO__Emplo__214BF109] DEFAULT 0,
    [EffDate] DATETIME2,
    [ExpDate] DATETIME2,
    [RateOverride] BIT CONSTRAINT [DF__EmplRateO__RateO__22401542] DEFAULT 0,
    [Note] NVARCHAR(255),
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[EmplVacation] (
    [EmplVacationRecID] INT NOT NULL IDENTITY(1,1),
    [EmployeeID] INT CONSTRAINT [DF__EmplVacat__Emplo__2334397B] DEFAULT 0,
    [StartDate] DATETIME2,
    [EndDate] DATETIME2,
    [Notes] NVARCHAR(100),
    [Submit] BIT CONSTRAINT [DF__EmplVacat__Submi__24285DB4] DEFAULT 0,
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [EmplVacation$PrimaryKey] PRIMARY KEY CLUSTERED ([EmplVacationRecID])
);

-- CreateTable
CREATE TABLE [dbo].[EmplVacationSubstitute] (
    [SubstituteRecID] INT NOT NULL IDENTITY(1,1),
    [SubstituteSumRecID] INT CONSTRAINT [DF__EmplVacat__Subst__251C81ED] DEFAULT 0,
    [EmplVacationRecID] INT CONSTRAINT [DF__EmplVacat__EmplV__2610A626] DEFAULT 0,
    [SSN] NVARCHAR(9),
    [EmployeeID] INT CONSTRAINT [DF__EmplVacat__Emplo__2704CA5F] DEFAULT 0,
    [ServiceID] INT,
    [DayID] INT,
    [Time] REAL,
    [StartTime] DATETIME2,
    [EffDate] DATETIME2,
    [ExpDate] DATETIME2,
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [EmplVacationSubstitute$PrimaryKey] PRIMARY KEY CLUSTERED ([SubstituteRecID])
);

-- CreateTable
CREATE TABLE [dbo].[EmplVacationSubstituteSum] (
    [SubstituteSumRecID] INT NOT NULL IDENTITY(1,1),
    [EmplVacationRecID] INT CONSTRAINT [DF__EmplVacat__EmplV__27F8EE98] DEFAULT 0,
    [SSN] NVARCHAR(9),
    [EmployeeID] INT CONSTRAINT [DF__EmplVacat__Emplo__28ED12D1] DEFAULT 0,
    CONSTRAINT [EmplVacationSubstituteSum$PrimaryKey] PRIMARY KEY CLUSTERED ([SubstituteSumRecID])
);

-- CreateTable
CREATE TABLE [dbo].[EVV_Visit] (
    [RecID] INT NOT NULL IDENTITY(1,1),
    [StaffFirstName] NVARCHAR(25),
    [StaffLastName] NVARCHAR(50),
    [StaffMI] NVARCHAR(1),
    [StaffAgencyID] INT,
    [StaffAPI] NVARCHAR(255),
    [StaffOtherID2] INT,
    [ClientFirstName] NVARCHAR(25),
    [StaffTeamID] NVARCHAR(6),
    [ClientLastName] NVARCHAR(50),
    [ClientMI] NVARCHAR(1),
    [ClientChartID] NVARCHAR(25),
    [ClientAdmitType] NVARCHAR(25),
    [ClientOtherID] NVARCHAR(25),
    [LocationID] NVARCHAR(6),
    [Date] DATETIME2,
    [TypeID] NVARCHAR(6),
    [ScheduleID] INT CONSTRAINT [DF__EVV_Visit__Sched__29E1370A] DEFAULT 0,
    [ServiceID] NVARCHAR(6),
    [EventID] NVARCHAR(6),
    [OldSchedID] NVARCHAR(60),
    [TimeIN] NVARCHAR(255),
    [Proposed Start] NVARCHAR(255),
    [TimeOut] NVARCHAR(255),
    [Proposed End] NVARCHAR(255),
    [Duration] REAL,
    [Timezone] NVARCHAR(6),
    [Override] INT,
    [Comments] NVARCHAR(240),
    [TaskID] NVARCHAR(240),
    [Task Notes] NVARCHAR(255),
    [Reason Code] NVARCHAR(6),
    [Task Notes Type] NVARCHAR(150),
    [Reason Code Description] NVARCHAR(240),
    [Batch] DATETIME2,
    [FileName] NVARCHAR(50),
    [StartTime] DATETIME2 CONSTRAINT [DF__EVV_Visit__Start__2AD55B43] DEFAULT 12/30/1899,
    [EndTime] DATETIME2 CONSTRAINT [DF__EVV_Visit__EndTi__2BC97F7C] DEFAULT 12/30/1899,
    [SSN] NVARCHAR(9),
    [ServiceIDGroup] INT,
    [Duplicate] BIT CONSTRAINT [DF__EVV_Visit__Dupli__2CBDA3B5] DEFAULT 0,
    [DurationPay] REAL CONSTRAINT [DF__EVV_Visit__Durat__2DB1C7EE] DEFAULT 0,
    [Slip24] BIT CONSTRAINT [DF__EVV_Visit__Slip2__2EA5EC27] DEFAULT 0,
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[EVVEvents] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [VisitId] NVARCHAR(64) NOT NULL,
    [UserId] INT NOT NULL,
    [EventType] NVARCHAR(20) NOT NULL,
    [CapturedAt] DATETIME2 NOT NULL,
    [Lat] DECIMAL(9,6),
    [Lng] DECIMAL(9,6),
    [AccuracyMeters] INT,
    [DeviceInfo] NVARCHAR(400),
    [IpAddress] NVARCHAR(80),
    [UserAgent] NVARCHAR(400),
    [IsLocationDenied] BIT NOT NULL CONSTRAINT [DF__EVVEvents__IsLoc__5A846E65] DEFAULT 0,
    [DenyReason] NVARCHAR(200),
    CONSTRAINT [PK__EVVEvent__3214EC075B4FF680] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[EVVPr] (
    [id] NVARCHAR(11) NOT NULL,
    [det] NVARCHAR(255),
    [amount] NVARCHAR(255),
    [detcode] NVARCHAR(255),
    [hours] FLOAT(53),
    [cc1] NVARCHAR(255),
    [rate] INT,
    [ratecode] NVARCHAR(255),
    [cc2] NVARCHAR(255),
    [cc3] NVARCHAR(255),
    [cc4] NVARCHAR(255),
    [begin date] DATETIME2,
    [jobcode] NVARCHAR(255),
    [shift] NVARCHAR(255),
    [end date] DATETIME2,
    [wwc] NVARCHAR(255),
    [tcode1] NVARCHAR(255),
    [tcode2] NVARCHAR(255),
    [comment] INT,
    [tcode3] NVARCHAR(255),
    [tcode4] NVARCHAR(255),
    [wcc] NVARCHAR(255),
    [BaseRate] FLOAT(53),
    [WageParity] NVARCHAR(255),
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[FCARate] (
    [EffDate] DATETIME2,
    [ExpDate] DATETIME2,
    [ServiceID] SMALLINT CONSTRAINT [DF__FCARate__Service__2F9A1060] DEFAULT 0,
    [Rate] FLOAT(53) CONSTRAINT [DF__FCARate__Rate__308E3499] DEFAULT 0,
    [Note] NVARCHAR(255),
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[Firm] (
    [FirmID] INT NOT NULL IDENTITY(1,1),
    [FirmName] NVARCHAR(50),
    [FirmCode] NVARCHAR(2),
    [Address] NVARCHAR(50),
    [Telephone] NVARCHAR(50),
    [Fax] NVARCHAR(50),
    [ProviderNoCCCI] NVARCHAR(50),
    [ProviderNoDSS] NVARCHAR(50),
    [Manager] NVARCHAR(50),
    [SendFilePath] NVARCHAR(50),
    [ReportFilePath] NVARCHAR(50),
    [ExternalDB] NVARCHAR(50),
    [ElectronicPrice] NVARCHAR(20),
    [ProviderFEIN] NVARCHAR(50),
    [Manager2] NVARCHAR(50),
    [ProviderNoPR] NVARCHAR(20),
    [ProviderNoEVV] NVARCHAR(20),
    [EVV_VisitDir] NVARCHAR(50),
    CONSTRAINT [Firm$PrimaryKey] PRIMARY KEY CLUSTERED ([FirmID])
);

-- CreateTable
CREATE TABLE [dbo].[HMOpenMonth] (
    [SSN] NVARCHAR(9),
    [ServiceDate] DATETIME2,
    [ServiceIDGroup] INT,
    [TotalTime] FLOAT(53),
    [Rate] REAL CONSTRAINT [DF__HMOpenMont__Rate__318258D2] DEFAULT 0,
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[HMOpenWeek] (
    [SSN] NVARCHAR(9),
    [ServiceDate] DATETIME2,
    [ServiceIDGroup] INT,
    [EmployeeID] INT,
    [Time] FLOAT(53),
    [Done] BIT CONSTRAINT [DF__HMOpenWeek__Done__32767D0B] DEFAULT 0,
    [StartTime] DATETIME2,
    [EndTime] DATETIME2,
    [Schedule] NVARCHAR(255),
    [Notes] NVARCHAR(40),
    [Period] INT CONSTRAINT [DF__HMOpenWee__Perio__336AA144] DEFAULT 0,
    [ServiceTypeCd] NVARCHAR(2),
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[HMPayRollTimeSheet] (
    [ID] INT NOT NULL IDENTITY(1,1),
    [EmployeeID] INT CONSTRAINT [DF__HMPayRoll__Emplo__345EC57D] DEFAULT 0,
    [SSN] NVARCHAR(9),
    [ServiceDate] DATETIME2,
    [ServiceIDGroup] INT CONSTRAINT [DF__HMPayRoll__Servi__3552E9B6] DEFAULT 0,
    [TotalTime] REAL CONSTRAINT [DF__HMPayRoll__Total__36470DEF] DEFAULT 0,
    [Rate] REAL CONSTRAINT [DF__HMPayRollT__Rate__373B3228] DEFAULT 0,
    [PayDate] DATETIME2,
    [Notes] NVARCHAR(50),
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [HMPayRollTimeSheet$PrimaryKey] PRIMARY KEY CLUSTERED ([ID])
);

-- CreateTable
CREATE TABLE [dbo].[HMTimeSheet] (
    [ID] INT NOT NULL IDENTITY(1,1),
    [EmployeeID] INT CONSTRAINT [DF__HMTimeShe__Emplo__382F5661] DEFAULT 0,
    [SSN] NVARCHAR(9),
    [ServiceDate] DATETIME2,
    [ServiceIDGroup] INT CONSTRAINT [DF__HMTimeShe__Servi__39237A9A] DEFAULT 0,
    [TotalTime] REAL CONSTRAINT [DF__HMTimeShe__Total__3A179ED3] DEFAULT 0,
    [Rate] REAL CONSTRAINT [DF__HMTimeShee__Rate__3B0BC30C] DEFAULT 0,
    [PayDate] DATETIME2,
    [Notes] NVARCHAR(50),
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [HMTimeSheet$PrimaryKey] PRIMARY KEY CLUSTERED ([ID])
);

-- CreateTable
CREATE TABLE [dbo].[ICD10] (
    [ID] INT NOT NULL IDENTITY(1,1),
    [ICD9] NVARCHAR(255),
    [Description] NVARCHAR(255),
    [ICD10] NVARCHAR(255),
    CONSTRAINT [ICD10$PrimaryKey] PRIMARY KEY CLUSTERED ([ID])
);

-- CreateTable
CREATE TABLE [dbo].[Invoice] (
    [InvID] INT CONSTRAINT [DF__Invoice__InvID__3BFFE745] DEFAULT 0,
    [ServiceDate] DATETIME2,
    [SSN] NVARCHAR(9),
    [ServiceIDGroup] INT CONSTRAINT [DF__Invoice__Service__3CF40B7E] DEFAULT 0,
    [TotalTime] REAL,
    [UnpaidTime] REAL CONSTRAINT [DF__Invoice__UnpaidT__3DE82FB7] DEFAULT 0,
    [UnpaidCode] TINYINT,
    [Charge] REAL,
    [Paid] REAL,
    [Loss] REAL,
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[InvoiceReminder] (
    [InvID] INT CONSTRAINT [DF__InvoiceRe__InvID__3EDC53F0] DEFAULT 0,
    [RemDate] DATETIME2,
    [Action] NVARCHAR(255)
);

-- CreateTable
CREATE TABLE [dbo].[InvoiceTitle] (
    [InvID] INT NOT NULL IDENTITY(1,1),
    [InvMonth] SMALLINT,
    [InvYear] SMALLINT,
    [ServiceCode] NVARCHAR(3),
    [SSN] NVARCHAR(9),
    [DSS] INT,
    [LastName] NVARCHAR(50),
    [FirstName] NVARCHAR(50),
    [BillAmount] REAL,
    [PaidAmount] REAL,
    [LossAmount] REAL,
    [Paid] BIT CONSTRAINT [DF__InvoiceTit__Paid__3FD07829] DEFAULT 0,
    [Notes] NVARCHAR(20),
    [CheckDetailId1] INT,
    [Amount1] REAL,
    [CheckDetailId2] INT,
    [Amount2] REAL,
    [CheckDetailId3] INT,
    [Amount3] REAL,
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[mnuLanguage] (
    [LanguageID] INT NOT NULL IDENTITY(1,1),
    [LanguageDesc] NVARCHAR(50),
    CONSTRAINT [mnuLanguage$PrimaryKey] PRIMARY KEY CLUSTERED ([LanguageID])
);

-- CreateTable
CREATE TABLE [dbo].[Narrative] (
    [RecID] INT NOT NULL IDENTITY(1,1),
    [SSN] NVARCHAR(9),
    [EffDate] DATETIME2,
    [Description] NVARCHAR(255),
    CONSTRAINT [Narrative$PrimaryKey] PRIMARY KEY CLUSTERED ([RecID])
);

-- CreateTable
CREATE TABLE [dbo].[PriceList] (
    [EffDate] DATETIME2,
    [ExpDate] DATETIME2,
    [ServiceID] SMALLINT CONSTRAINT [DF__PriceList__Servi__40C49C62] DEFAULT 0,
    [ServiceCode] NVARCHAR(10),
    [ServiceCodeHP] NVARCHAR(10),
    [Price] FLOAT(53) CONSTRAINT [DF__PriceList__Price__41B8C09B] DEFAULT 0,
    [Price2] FLOAT(53) CONSTRAINT [DF__PriceList__Price__42ACE4D4] DEFAULT 0,
    [Notes] NVARCHAR(40),
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[PriceListPrivate] (
    [EffDate] DATETIME2,
    [ExpDate] DATETIME2,
    [SSN] NVARCHAR(9),
    [ServiceID] SMALLINT CONSTRAINT [DF__PriceList__Servi__43A1090D] DEFAULT 0,
    [ServiceCode] NVARCHAR(10),
    [Price] REAL CONSTRAINT [DF__PriceList__Price__44952D46] DEFAULT 0,
    [Notes] NVARCHAR(25),
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[Reminder] (
    [ID] INT NOT NULL IDENTITY(1,1),
    [RemDate] DATETIME2,
    [SSN] NVARCHAR(9),
    [Text] NVARCHAR(255),
    [ActionDate] DATETIME2,
    [Active] BIT CONSTRAINT [DF__Reminder__Active__4589517F] DEFAULT 0,
    [Action] NVARCHAR(80),
    [Result] NVARCHAR(80),
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [Reminder$PrimaryKey] PRIMARY KEY CLUSTERED ([ID])
);

-- CreateTable
CREATE TABLE [dbo].[ServiceCatalog] (
    [ServiceID] INT NOT NULL CONSTRAINT [DF__ServiceCa__Servi__467D75B8] DEFAULT 0,
    [Service] NVARCHAR(50),
    [Frequency] SMALLINT CONSTRAINT [DF__ServiceCa__Frequ__477199F1] DEFAULT 0,
    [UnitHrs] REAL CONSTRAINT [DF__ServiceCa__UnitH__4865BE2A] DEFAULT 0,
    [ServiceAbbr] NVARCHAR(15),
    [ServiceDesc2] NVARCHAR(50),
    [SSMA_TimeStamp] timestamp NOT NULL,
    CONSTRAINT [ServiceCatalog$PrimaryKey] PRIMARY KEY CLUSTERED ([ServiceID])
);

-- CreateTable
CREATE TABLE [dbo].[ServiceOrderCatalog] (
    [ServiceID] NVARCHAR(10) NOT NULL,
    [Service] NVARCHAR(50),
    [Frequency] SMALLINT CONSTRAINT [DF__ServiceOr__Frequ__4959E263] DEFAULT 0,
    [TaskGroupID] NVARCHAR(10),
    CONSTRAINT [ServiceOrderCatalog$PrimaryKey] PRIMARY KEY CLUSTERED ([ServiceID])
);

-- CreateTable
CREATE TABLE [dbo].[Users] (
    [Users] NCHAR(10),
    [display_name] NCHAR(10),
    [caregiver-user] NCHAR(10)
);

-- CreateTable
CREATE TABLE [dbo].[Vacation] (
    [SSN] NVARCHAR(9),
    [From] DATETIME2,
    [To] DATETIME2,
    [HM] BIT CONSTRAINT [DF__Vacation__HM__4A4E069C] DEFAULT 0,
    [ADC] BIT CONSTRAINT [DF__Vacation__ADC__4B422AD5] DEFAULT 0,
    [Notes] NVARCHAR(255),
    [SSMA_TimeStamp] timestamp NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[VisitApprovals] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [VisitId] NVARCHAR(64) NOT NULL,
    [ApprovedByUserId] INT NOT NULL,
    [ApprovedAt] DATETIME2 NOT NULL CONSTRAINT [DF__VisitAppr__Appro__5E54FF49] DEFAULT sysutcdatetime(),
    [Note] NVARCHAR(500),
    CONSTRAINT [PK__VisitApp__3214EC07E5543609] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Visits] (
    [Visits] NCHAR(10),
    [StartPlanned] NCHAR(10),
    [EndPlanned] NCHAR(10),
    [Status] NCHAR(10)
);

-- CreateIndex
CREATE NONCLUSTERED INDEX [CaseMng$CaseMngID1] ON [dbo].[CaseMng]([CaseMngID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [CheckDetail$CheckDetailID] ON [dbo].[CheckDetail]([CheckDetailID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [CheckDetail$CheckID] ON [dbo].[CheckDetail]([CheckID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [CheckTitle$CheckId] ON [dbo].[CheckTitle]([CheckId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Client2$CaseNamagerID] ON [dbo].[Client2]([CaseManagerID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Client2$CCCINum] ON [dbo].[Client2]([CCCINum]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Client2$DiagCode] ON [dbo].[Client2]([DiagCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Client2$FundNum] ON [dbo].[Client2]([FundNum]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Client2$Medicaid] ON [dbo].[Client2]([Medicaid]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientAssignedHour$RecID] ON [dbo].[ClientAssignedHour]([RecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientAssignedHour$SSN] ON [dbo].[ClientAssignedHour]([SSN]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientAssignedHourExtra$ClientYM] ON [dbo].[ClientAssignedHourExtra]([SSN], [Year], [MonthID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientMedStatus$RecID1] ON [dbo].[ClientMedStatus]([RecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientNarrativeSupervision$EmploieeId] ON [dbo].[ClientNarrativeSupervision]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientNarrativeSupervision$RecId] ON [dbo].[ClientNarrativeSupervision]([RecId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientProviderReport$ProviderReportID] ON [dbo].[ClientProviderReport]([RecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientProviderReport$ServiceId] ON [dbo].[ClientProviderReport]([ServiceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientService$DaID] ON [dbo].[ClientService]([DayID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientService$EmployeeID] ON [dbo].[ClientService]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientService$ServiceID] ON [dbo].[ClientService]([ServiceID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientService$SSN] ON [dbo].[ClientService]([SSN]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientServiceHistory$DaID] ON [dbo].[ClientServiceHistory]([DayID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientServiceHistory$EmployeeID] ON [dbo].[ClientServiceHistory]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientServiceHistory$ServiceID] ON [dbo].[ClientServiceHistory]([ServiceID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientServiceHistory$SSN] ON [dbo].[ClientServiceHistory]([SSN]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientServiceM$DaID] ON [dbo].[ClientServiceM]([DayID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientServiceM$EmployeeID] ON [dbo].[ClientServiceM]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientServiceM$ServiceID] ON [dbo].[ClientServiceM]([ServiceID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientServiceM$SSN] ON [dbo].[ClientServiceM]([SSN]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientServiceMDone$EmployeeID] ON [dbo].[ClientServiceMDone]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientServiceMDone$RecID] ON [dbo].[ClientServiceMDone]([RecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientServiceOrder$RecID] ON [dbo].[ClientServiceOrder]([RecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientServiceOrder$ServiceId] ON [dbo].[ClientServiceOrder]([ServiceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ClientServiceOrder$VendorCode] ON [dbo].[ClientServiceOrder]([VendorCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EDI_837P_ISA$FieldID] ON [dbo].[EDI_837P_ISA]([ElementID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EDI_837P_ISA$RecID] ON [dbo].[EDI_837P_ISA]([RecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EDI_837P_ISA$SegID] ON [dbo].[EDI_837P_ISA]([SegID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EDI_837P_SegmentValue$FieldID] ON [dbo].[EDI_837P_SegmentValue]([ElementID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EDI_837P_SegmentValue$LoopID] ON [dbo].[EDI_837P_SegmentValue]([LoopID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EDI_837P_SegmentValue$RecID] ON [dbo].[EDI_837P_SegmentValue]([RecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EDI_837P_SegmentValue$SegID] ON [dbo].[EDI_837P_SegmentValue]([SegID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EDI_Batch$BatchNum] ON [dbo].[EDI_Batch]([BatchNum]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EDI_Processor$PROCESSOR_ID_CODE] ON [dbo].[EDI_Processor]([PROCESSOR_ID_CODE]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EDI_Provider$PROV_CODE] ON [dbo].[EDI_Provider]([Prov_Code]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EDI_Provider$TAX_ID] ON [dbo].[EDI_Provider]([TAX_ID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplMileage$EmployeeID] ON [dbo].[EmplMileage]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplNarrative$EmployeeID] ON [dbo].[EmplNarrative]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplNarrative$RecId] ON [dbo].[EmplNarrative]([RecId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Employee$PrimaryLanguageID] ON [dbo].[Employee]([PrimaryLanguageID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Employee$SecondaryLanguageID] ON [dbo].[Employee]([SecondaryLanguageID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Employee$Zip Code] ON [dbo].[Employee]([Zip Code]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplRateOverride$EmployeeID] ON [dbo].[EmplRateOverride]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplVacation$EmployeeID] ON [dbo].[EmplVacation]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplVacation$EmplVacationID] ON [dbo].[EmplVacation]([EmplVacationRecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplVacationSubstitute$DayID] ON [dbo].[EmplVacationSubstitute]([DayID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplVacationSubstitute$EmployeeID] ON [dbo].[EmplVacationSubstitute]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplVacationSubstitute$EmplVacationRecID] ON [dbo].[EmplVacationSubstitute]([EmplVacationRecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplVacationSubstitute$ServiceID] ON [dbo].[EmplVacationSubstitute]([ServiceID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplVacationSubstitute$SSN] ON [dbo].[EmplVacationSubstitute]([SSN]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplVacationSubstitute$SubstituteRecID] ON [dbo].[EmplVacationSubstitute]([SubstituteRecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplVacationSubstitute$SubstituteSumRecID] ON [dbo].[EmplVacationSubstitute]([SubstituteSumRecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplVacationSubstituteSum$EmployeeID] ON [dbo].[EmplVacationSubstituteSum]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplVacationSubstituteSum$EmplVacationRecID] ON [dbo].[EmplVacationSubstituteSum]([EmplVacationRecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplVacationSubstituteSum$SSN] ON [dbo].[EmplVacationSubstituteSum]([SSN]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EmplVacationSubstituteSum$SubstituteRecID] ON [dbo].[EmplVacationSubstituteSum]([SubstituteSumRecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVV_Visit$ClientChartID] ON [dbo].[EVV_Visit]([ClientChartID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVV_Visit$ClientOtherID] ON [dbo].[EVV_Visit]([ClientOtherID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVV_Visit$EventID] ON [dbo].[EVV_Visit]([EventID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVV_Visit$LocationID] ON [dbo].[EVV_Visit]([LocationID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVV_Visit$OldSchedID] ON [dbo].[EVV_Visit]([OldSchedID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVV_Visit$Reason Code] ON [dbo].[EVV_Visit]([Reason Code]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVV_Visit$RecID] ON [dbo].[EVV_Visit]([RecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVV_Visit$ScheduleID] ON [dbo].[EVV_Visit]([ScheduleID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVV_Visit$ServiceID] ON [dbo].[EVV_Visit]([ServiceID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVV_Visit$StaffAgencyID] ON [dbo].[EVV_Visit]([StaffAgencyID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVV_Visit$StaffTeamID] ON [dbo].[EVV_Visit]([StaffTeamID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVV_Visit$TaskID] ON [dbo].[EVV_Visit]([TaskID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVV_Visit$TypeID] ON [dbo].[EVV_Visit]([TypeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVVPr$detcode] ON [dbo].[EVVPr]([detcode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVVPr$id] ON [dbo].[EVVPr]([id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVVPr$jobcode] ON [dbo].[EVVPr]([jobcode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EVVPr$ratecode] ON [dbo].[EVVPr]([ratecode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [FCARate$ServiceID] ON [dbo].[FCARate]([ServiceID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Firm$FirmCode] ON [dbo].[Firm]([FirmCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [HMOpenWeek$EmployeeID] ON [dbo].[HMOpenWeek]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [HMPayRollTimeSheet$EmployeeID] ON [dbo].[HMPayRollTimeSheet]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [HMTimeSheet$EmployeeID] ON [dbo].[HMTimeSheet]([EmployeeID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Invoice$DietCode] ON [dbo].[Invoice]([ServiceIDGroup]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Invoice$InvID] ON [dbo].[Invoice]([InvID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Invoice$Paid] ON [dbo].[Invoice]([Paid]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Invoice$UnpaidCode] ON [dbo].[Invoice]([UnpaidCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [InvoiceReminder$InvID] ON [dbo].[InvoiceReminder]([InvID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [InvoiceTitle$InvID] ON [dbo].[InvoiceTitle]([InvID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [InvoiceTitle$Paid] ON [dbo].[InvoiceTitle]([Paid]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [InvoiceTitle$ServiceCode] ON [dbo].[InvoiceTitle]([ServiceCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [mnuLanguage$languageID] ON [dbo].[mnuLanguage]([LanguageID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Narrative$RecID1] ON [dbo].[Narrative]([RecID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [PriceList$ServiceCode] ON [dbo].[PriceList]([ServiceCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [PriceList$ServiceID] ON [dbo].[PriceList]([ServiceID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [PriceListPrivate$ServiceCode] ON [dbo].[PriceListPrivate]([ServiceCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [PriceListPrivate$ServiceID] ON [dbo].[PriceListPrivate]([ServiceID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [PriceListPrivate$SSN] ON [dbo].[PriceListPrivate]([SSN]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ServiceCatalog$SErviceID] ON [dbo].[ServiceCatalog]([ServiceID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ServiceOrderCatalog$TaskGroupID] ON [dbo].[ServiceOrderCatalog]([TaskGroupID]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Vacation$SSN] ON [dbo].[Vacation]([SSN]);

-- AddForeignKey
ALTER TABLE [dbo].[AppUserRoles] ADD CONSTRAINT [FK__AppUserRo__RoleI__56B3DD81] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AppRoles]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[AppUserRoles] ADD CONSTRAINT [FK__AppUserRo__UserI__55BFB948] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AppUsers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[EVVEvents] ADD CONSTRAINT [FK__EVVEvents__UserI__59904A2C] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AppUsers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[VisitApprovals] ADD CONSTRAINT [FK__VisitAppr__Appro__5D60DB10] FOREIGN KEY ([ApprovedByUserId]) REFERENCES [dbo].[AppUsers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
