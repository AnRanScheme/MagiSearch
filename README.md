# MagiSearch
封装的searchViewController,目前,还在添加新的样式,请期待

## 如何使用


        let demoCategories = ["Menu", "Animation", "Transition", "TableView", "CollectionView", "Indicator", "Alert", "UIView", "UITextfield", "UITableView", "Swift", "iOS", "Android"]
        let demoSearchHistories = ["Menu", "Animation", "Transition", "TableView"]
        
        let magiSearch = MagiSearch()
        magiSearch.setCategories(value: demoCategories)
        magiSearch.setSearchHistories(value: demoSearchHistories)
        magiSearchInit()
        self.delegate = self

        let database1 = MagiDropDownMenu("MagiDropDownMenu")
        let database2 = MagiSearchData("MagiSearchData")
        let database3 = MagiExpandableCell("MagiExpandableCell")
        let demoDatabase = [database1, database2, database3]
        
        initData(demoDatabase)
        setmagiCategoryButtonType(type: .colorful)
        '''
        
        
