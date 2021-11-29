//
//  ViewController.swift
//  GoAndUp
//
//  Created by Guillaume Fourrier on 26/02/2021.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var episodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        Service.getEpisodes { episodes in
            self.episodes = episodes
        }
    }

    func setupTableView() {
        tableView.register(UINib(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "EpisodeCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail", let destination = segue.destination as? DetailViewController {
            destination.episode = sender as? Episode
            destination.modalPresentationStyle = .fullScreen
            destination.transitioningDelegate = self
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as? EpisodeCell {
            let episode: Episode
            episode = episodes[indexPath.row]
            
            cell.contentVw.layer.cornerRadius = 5
            cell.clipsToBounds = true
            cell.episodeLbl.text = "S\(episode.season) - E\(episode.number)"
            cell.descriptionLbl.text = episode.name
            cell.episodeImage.layer.cornerRadius = 5
            cell.episodeImage.clipsToBounds = true
            cell.episodeImage.sd_imageTransition = .fade
            cell.episodeImage.sd_setImage(with: episode.image.mediumUrl, completed: nil)
            
            return cell
        }
        return .init()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        self.performSegue(withIdentifier: "toDetail", sender: episode)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedIndexPathCell = tableView.indexPathForSelectedRow,
              let selectedCell = tableView.cellForRow(at: selectedIndexPathCell) as? EpisodeCell,
              let selectedCellSuperview = selectedCell.superview else { return nil }
        
        let transition = CardAnimationController(originFrame: self.view.frame)

        transition.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        return transition
    }
}
