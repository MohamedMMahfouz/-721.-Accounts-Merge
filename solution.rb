# @param {String[][]} accounts
# @return {String[][]}


def accounts_merge(accounts)
    @adjacent = {}
    @visited = {}

    merged_accounts = []
    populate_adjacent(accounts)
    accounts.each do |account|
        merged_account = []
        first_email = account[1]
        if (!@visited.key?(first_email))
            dfs(merged_account, first_email)
            merged_account.sort!
            account_name = account[0]
            merged_account.unshift(account_name)
            merged_accounts << merged_account
        end
    end
    merged_accounts
end

def dfs(merged_account, email)
    @visited[email] = true
    merged_account << email

    return unless @adjacent[email]

    @adjacent[email].each do |neighbor_email|
        if (!@visited[neighbor_email])
            dfs(merged_account, neighbor_email)
        end
    end
end


def populate_adjacent(accounts)
    accounts.each do |account|
        first_email = account[1]
    
        @adjacent[first_email] ||= []
        
        account_emails = account.drop(2)
        account_emails.each do |email|
            @adjacent[first_email] << email
            @adjacent[email] ||= []
            @adjacent[email] << first_email
        end
    end
end
