class Video {
  final String pageUrl, type, tags, pictureId, user, userImageUrl;
  final int id, duration, views, downloads, likes, comments, user_id;

  final VideoSizes availableResolutions;

  Video(
      {required this.id,
      required this.pageUrl,
      required this.type,
      required this.tags,
      required this.pictureId,
      required this.user,
      required this.userImageUrl,
      required this.duration,
      required this.views,
      required this.downloads,
      required this.likes,
      required this.comments,
      required this.user_id,
      required this.availableResolutions});

  factory Video.fromJson(Map json) {
    return Video(
      id: json["id"],
      pageUrl: json["pageURL"],
      type: json["type"],
      tags: json["tags"],
      pictureId: json["picture_id"],
      user: json["user"],
      userImageUrl: json["userImageURL"],
      duration: json["duration"],
      views: json["views"],
      downloads: json["downloads"],
      likes: json["likes"],
      comments: json["comments"],
      user_id: json["user_id"],
      availableResolutions: VideoSizes.fromJson(json['videos']),
    );
  }
}

class VideoSizes {
  final VideoResolution tiny;
  final VideoResolution small;
  final VideoResolution medium;
  final VideoResolution large;

  VideoSizes(
      {required this.tiny,
      required this.small,
      required this.medium,
      required this.large});

  factory VideoSizes.fromJson(Map json) {
    return VideoSizes(
      tiny: VideoResolution.fromJson(json['tiny']),
      small: VideoResolution.fromJson(json['small']),
      medium: VideoResolution.fromJson(json['medium']),
      large: VideoResolution.fromJson(json['large']),
    );
  }
}

class VideoResolution {
  final String url;
  final num width, height, size;

  VideoResolution(
      {required this.url,
      required this.width,
      required this.height,
      required this.size});

  factory VideoResolution.fromJson(Map json) {
    return VideoResolution(
        url: json['url'],
        width: json['width'],
        height: json['height'],
        size: json['size']);
  }
}
