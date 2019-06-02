//
//  GithubRepoSearchAppTests.swift
//  GithubRepoSearchAppTests
//
//  Created by Deepashri Khawase on 30.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import XCTest
@testable import GithubRepoSearchApp

class GithubRepoSearchAppTests: XCTestCase {
    var mockObserver: MockObserver = MockObserver()
    var mockNetworkService: MockNetworkService = MockNetworkService()
    var viewModel: RepositoryViewModelConfirming?
    override func setUp() {
        viewModel =  RepositoryViewModel(observer: mockObserver, networkService: mockNetworkService)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //[UT 1] Unit test for the Search functionality of VM
    func testViewModelSearchFunctionality() {
        //let exp = expectation(description: "Expectation that the network call will return")
        //wait(for: [exp], timeout: 3.0)
        viewModel?.performSearch(searchTerm: "searchTerm")
        XCTAssert(mockNetworkService.statusFlag == true, "Failure")
        XCTAssert(mockObserver.statusFlag == true, "Failure")
    }
}

// MockObserver: is a mock implementation for RepositoryViewModelObserving
class MockObserver: RepositoryViewModelObserving {
    var statusFlag = false
    func updateSearchResults() {
        statusFlag = true
    }
    
    func navigateToDetail(with data: Repository) {
        statusFlag = true
    }
}

// MockNetworkService: is a mock implementation of NetworkRequestProviding
class MockNetworkService: NetworkRequestProviding {
    var statusFlag = false
    func performSearch(searchTerm: String, completionBlock: @escaping completionHandler) {
        if let dummyResponse = try? RepositoryResponse(dummyJsonString, using: .utf8) {
            completionBlock(true, dummyResponse as AnyObject)
            statusFlag = true
        } else {
            completionBlock(false, "" as AnyObject)
            statusFlag = false
        }
    }
    
    func fetchSubscribers(repository: Repository, completionBlock: @escaping completionHandler) {
        statusFlag = true
    }
    let dummyJsonString = """
                {
                  "total_count": 1,
                  "incomplete_results": false,
                  "items": [
                    {
                      "id": 76954504,
                      "node_id": "MDEwOlJlcG9zaXRvcnk3Njk1NDUwNA==",
                      "name": "react-tetris",
                      "full_name": "chvin/react-tetris",
                      "private": false,
                      "owner": {
                        "login": "chvin",
                        "id": 5383506,
                        "node_id": "MDQ6VXNlcjUzODM1MDY=",
                        "avatar_url": "https://avatars2.githubusercontent.com/u/5383506?v=4",
                        "gravatar_id": "",
                        "url": "https://api.github.com/users/chvin",
                        "html_url": "https://github.com/chvin",
                        "followers_url": "https://api.github.com/users/chvin/followers",
                        "following_url": "https://api.github.com/users/chvin/following{/other_user}",
                        "gists_url": "https://api.github.com/users/chvin/gists{/gist_id}",
                        "starred_url": "https://api.github.com/users/chvin/starred{/owner}{/repo}",
                        "subscriptions_url": "https://api.github.com/users/chvin/subscriptions",
                        "organizations_url": "https://api.github.com/users/chvin/orgs",
                        "repos_url": "https://api.github.com/users/chvin/repos",
                        "events_url": "https://api.github.com/users/chvin/events{/privacy}",
                        "received_events_url": "https://api.github.com/users/chvin/received_events",
                        "type": "User",
                        "site_admin": false
                      },
                      "html_url": "https://github.com/chvin/react-tetris",
                      "description": "Use React, Redux, Immutable to code Tetris. 🎮",
                      "fork": false,
                      "url": "https://api.github.com/repos/chvin/react-tetris",
                      "forks_url": "https://api.github.com/repos/chvin/react-tetris/forks",
                      "keys_url": "https://api.github.com/repos/chvin/react-tetris/keys{/key_id}",
                      "collaborators_url": "https://api.github.com/repos/chvin/react-tetris/collaborators{/collaborator}",
                      "teams_url": "https://api.github.com/repos/chvin/react-tetris/teams",
                      "hooks_url": "https://api.github.com/repos/chvin/react-tetris/hooks",
                      "issue_events_url": "https://api.github.com/repos/chvin/react-tetris/issues/events{/number}",
                      "events_url": "https://api.github.com/repos/chvin/react-tetris/events",
                      "assignees_url": "https://api.github.com/repos/chvin/react-tetris/assignees{/user}",
                      "branches_url": "https://api.github.com/repos/chvin/react-tetris/branches{/branch}",
                      "tags_url": "https://api.github.com/repos/chvin/react-tetris/tags",
                      "blobs_url": "https://api.github.com/repos/chvin/react-tetris/git/blobs{/sha}",
                      "git_tags_url": "https://api.github.com/repos/chvin/react-tetris/git/tags{/sha}",
                      "git_refs_url": "https://api.github.com/repos/chvin/react-tetris/git/refs{/sha}",
                      "trees_url": "https://api.github.com/repos/chvin/react-tetris/git/trees{/sha}",
                      "statuses_url": "https://api.github.com/repos/chvin/react-tetris/statuses/{sha}",
                      "languages_url": "https://api.github.com/repos/chvin/react-tetris/languages",
                      "stargazers_url": "https://api.github.com/repos/chvin/react-tetris/stargazers",
                      "contributors_url": "https://api.github.com/repos/chvin/react-tetris/contributors",
                      "subscribers_url": "https://api.github.com/repos/chvin/react-tetris/subscribers",
                      "subscription_url": "https://api.github.com/repos/chvin/react-tetris/subscription",
                      "commits_url": "https://api.github.com/repos/chvin/react-tetris/commits{/sha}",
                      "git_commits_url": "https://api.github.com/repos/chvin/react-tetris/git/commits{/sha}",
                      "comments_url": "https://api.github.com/repos/chvin/react-tetris/comments{/number}",
                      "issue_comment_url": "https://api.github.com/repos/chvin/react-tetris/issues/comments{/number}",
                      "contents_url": "https://api.github.com/repos/chvin/react-tetris/contents/{+path}",
                      "compare_url": "https://api.github.com/repos/chvin/react-tetris/compare/{base}...{head}",
                      "merges_url": "https://api.github.com/repos/chvin/react-tetris/merges",
                      "archive_url": "https://api.github.com/repos/chvin/react-tetris/{archive_format}{/ref}",
                      "downloads_url": "https://api.github.com/repos/chvin/react-tetris/downloads",
                      "issues_url": "https://api.github.com/repos/chvin/react-tetris/issues{/number}",
                      "pulls_url": "https://api.github.com/repos/chvin/react-tetris/pulls{/number}",
                      "milestones_url": "https://api.github.com/repos/chvin/react-tetris/milestones{/number}",
                      "notifications_url": "https://api.github.com/repos/chvin/react-tetris/notifications{?since,all,participating}",
                      "labels_url": "https://api.github.com/repos/chvin/react-tetris/labels{/name}",
                      "releases_url": "https://api.github.com/repos/chvin/react-tetris/releases{/id}",
                      "deployments_url": "https://api.github.com/repos/chvin/react-tetris/deployments",
                      "created_at": "2016-12-20T12:26:11Z",
                      "updated_at": "2019-06-01T14:58:21Z",
                      "pushed_at": "2019-05-26T02:20:17Z",
                      "git_url": "git://github.com/chvin/react-tetris.git",
                      "ssh_url": "git@github.com:chvin/react-tetris.git",
                      "clone_url": "https://github.com/chvin/react-tetris.git",
                      "svn_url": "https://github.com/chvin/react-tetris",
                      "homepage": "https://chvin.github.io/react-tetris/?lan=en",
                      "size": 4319,
                      "stargazers_count": 5228,
                      "watchers_count": 5228,
                      "language": "JavaScript",
                      "has_issues": true,
                      "has_projects": true,
                      "has_downloads": true,
                      "has_wiki": true,
                      "has_pages": true,
                      "forks_count": 875,
                      "mirror_url": null,
                      "archived": false,
                      "disabled": false,
                      "open_issues_count": 0,
                      "license": null,
                      "forks": 875,
                      "open_issues": 0,
                      "watchers": 5228,
                      "default_branch": "master",
                      "score": 144.3616
                    }
                  ]
                }
               """
}
